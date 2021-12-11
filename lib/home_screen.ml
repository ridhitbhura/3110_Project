open Yojson.Basic.Util

type t = {
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
  window_title : string;
  background_image : string;
  buttons : Button.t list;
  pop_ups : Subscreen.t list;
  number_players : int;
  current_character_selected : string;
  selected_characters : string list;
}

type response =
  | NoButtonClicked
  | Response of t * bool
  | ProceedToGS

let image hs = hs.background_image

let x_coord hs = hs.x_coord

let y_coord hs = hs.y_coord

let width hs = hs.width

let height hs = hs.height

let window_title hs = hs.window_title

let popups hs = hs.pop_ups

let change_popups hs popup_list = { hs with pop_ups = popup_list }

let replace_buttons hs button_list = { hs with buttons = button_list }

let buttons hs = hs.buttons

let get_home_screen_from_json (json : Yojson.Basic.t) : t =
  let hs_json = json |> member "home_screen" in
  {
    x_coord = hs_json |> member "x_coord" |> to_int;
    y_coord = hs_json |> member "y_coord" |> to_int;
    width = hs_json |> member "width" |> to_int;
    height = hs_json |> member "height" |> to_int;
    window_title = hs_json |> member "window_title" |> to_string;
    background_image = hs_json |> member "image_name" |> to_string;
    buttons =
      hs_json |> member "buttons" |> Button.get_buttons_from_json;
    pop_ups =
      hs_json |> member "subscreens"
      |> Subscreen.get_subscreens_from_json;
    number_players = 0;
    current_character_selected = "";
    selected_characters = [];
  }

let rec check_button_clicked_aux buttons (x, y) =
  match buttons with
  | [] -> None
  | h :: t ->
      if Button.is_clicked h (x, y) then Some h
      else check_button_clicked_aux t (x, y)

let check_button_clicked hs (x, y) =
  let buttons = hs.buttons in
  check_button_clicked_aux buttons (x, y)

let response_to_num_players_button hs btn subscreen_name number =
  let subscreen =
    List.find (fun x -> Subscreen.name x = subscreen_name) hs.pop_ups
  in
  let dimmed_btn = Button.dim btn in
  let btns =
    List.filter
      (fun x -> Button.name x <> Button.name btn)
      (Subscreen.buttons subscreen)
  in
  let reactivated_btns = List.map Button.undim btns in
  let new_btns = dimmed_btn :: reactivated_btns in
  let new_sub = Subscreen.replace_buttons subscreen new_btns in
  let subscreens =
    List.filter (fun x -> Subscreen.name x <> subscreen_name) hs.pop_ups
  in
  let new_subscreens = new_sub :: subscreens in
  { hs with pop_ups = new_subscreens; number_players = number }

let response_to_start_button hs =
  let s =
    List.find
      (fun s -> Subscreen.name s = Constants.number_players_popup)
      hs.pop_ups
  in
  let activated_s = Subscreen.activate s in
  let new_screens =
    activated_s
    :: List.filter
         (fun s -> Subscreen.name s <> Constants.number_players_popup)
         hs.pop_ups
  in
  { hs with pop_ups = new_screens }

let response_to_okay_button hs =
  match hs.number_players = 0 with
  | false ->
      let num_players_screen =
        List.find
          (fun x -> Subscreen.name x = Constants.number_players_popup)
          hs.pop_ups
      in
      let select_character_screen =
        List.find
          (fun x -> Subscreen.name x = Constants.select_character_popup)
          hs.pop_ups
      in
      let rest_screens =
        List.filter
          (fun x ->
            Subscreen.name x <> Constants.number_players_popup
            && Subscreen.name x <> Constants.select_character_popup)
          hs.pop_ups
      in
      let deactivated_num_player =
        Subscreen.deactivate num_players_screen
      in
      let activated_select_character =
        Subscreen.activate select_character_screen
      in
      {
        hs with
        pop_ups =
          activated_select_character :: deactivated_num_player
          :: rest_screens;
      }
  | true -> hs

let response_to_character_button hs btn subscreen_name =
  let subscreen =
    List.find (fun x -> Subscreen.name x = subscreen_name) hs.pop_ups
  in
  let dimmed_btn = Button.dim btn in
  let btns =
    List.filter
      (fun x -> Button.name x <> Button.name btn)
      (Subscreen.buttons subscreen)
  in
  let rec reactivate btns =
    match btns with
    | [] -> []
    | h :: t -> begin
        match
          List.exists
            (fun x -> Button.name h = x)
            hs.selected_characters
        with
        | true -> h :: reactivate t
        | false -> Button.undim h :: reactivate t
      end
  in
  let reactivated_buttons = reactivate btns in
  let new_btns = dimmed_btn :: reactivated_buttons in
  let new_sub = Subscreen.replace_buttons subscreen new_btns in
  let subscreens =
    List.filter (fun x -> Subscreen.name x <> subscreen_name) hs.pop_ups
  in
  let new_subscreens = new_sub :: subscreens in
  {
    hs with
    pop_ups = new_subscreens;
    current_character_selected = Button.name btn;
  }

let response_to_char_okay_button hs =
  let subscreen =
    List.find
      (fun x -> Subscreen.name x = Constants.select_character_popup)
      hs.pop_ups
  in
  let filtered_screens =
    List.filter
      (fun x -> Subscreen.name x <> Constants.select_character_popup)
      hs.pop_ups
  in
  match List.length hs.selected_characters + 1 = hs.number_players with
  | true -> ProceedToGS
  | false ->
      let selected_characters =
        hs.current_character_selected :: hs.selected_characters
      in
      let dynamic_images = Subscreen.images subscreen in
      let filtered_images =
        List.filter
          (fun x ->
            Dynamic_image.name x <> Constants.select_char_dynamic_image)
          dynamic_images
      in
      let number_image =
        List.find
          (fun x ->
            Dynamic_image.name x = Constants.select_char_dynamic_image)
          dynamic_images
      in
      let cleaned = Dynamic_image.clear_images number_image in
      let new_number_image =
        Dynamic_image.add_image cleaned
          (List.length selected_characters + 1)
      in
      let new_dynamic_images = new_number_image :: filtered_images in
      let new_subscreen =
        Subscreen.replace_dynamic_images subscreen new_dynamic_images
      in
      let new_subscreens = new_subscreen :: filtered_screens in
      Response
        ({ hs with selected_characters; pop_ups = new_subscreens }, true)

let get_buttons hs =
  let main_buttons = hs.buttons in
  let rec find_active_subscreen subscreens =
    match subscreens with
    | [] -> None
    | h :: t ->
        if Subscreen.active h then Some h else find_active_subscreen t
  in
  match find_active_subscreen hs.pop_ups with
  | None -> main_buttons
  | Some h -> Subscreen.buttons h

let check_button_click_and_respond hs (x, y) =
  let buttons = get_buttons hs in
  let clicked_button = check_button_clicked_aux buttons (x, y) in
  match clicked_button with
  | None -> NoButtonClicked
  | Some btn -> (
      match Button.name btn with
      | s when s = Constants.start_button ->
          Response (response_to_start_button hs, false)
      | s when s = Constants.two_players_button ->
          Response
            ( response_to_num_players_button hs btn
                Constants.number_players_popup 2,
              false )
      | s when s = Constants.four_players_button ->
          Response
            ( response_to_num_players_button hs btn
                Constants.number_players_popup 4,
              false )
      | s when s = Constants.six_players_button ->
          Response
            ( response_to_num_players_button hs btn
                Constants.number_players_popup 6,
              false )
      | s when s = Constants.num_players_okay_button ->
          Response (response_to_okay_button hs, true)
      | s when s = Constants.character_one_button ->
          Response
            ( response_to_character_button hs btn
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_two_button ->
          Response
            ( response_to_character_button hs btn
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_three_button ->
          Response
            ( response_to_character_button hs btn
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_four_button ->
          Response
            ( response_to_character_button hs btn
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_five_button ->
          Response
            ( response_to_character_button hs btn
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_six_button ->
          Response
            ( response_to_character_button hs btn
                Constants.select_character_popup,
              false )
      | s when s = Constants.select_char_okay_button ->
          response_to_char_okay_button hs
      | _ -> failwith "TODO")
