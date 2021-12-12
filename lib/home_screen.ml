open Yojson.Basic.Util
open Maps

type button_map = Button.t SM.t

type subscreen_map = Subscreen.t SM.t

type t = {
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
  window_title : string;
  background_image : string;
  buttons : button_map;
  subscreens : subscreen_map;
  number_players : int;
  current_character_selected : string;
  selected_characters : string list;
}

type response =
  | NoButtonClicked
  | NewHS of t * bool
  | ProceedToGS

let image hs = hs.background_image

let x_coord hs = hs.x_coord

let y_coord hs = hs.y_coord

let width hs = hs.width

let height hs = hs.height

let window_title hs = hs.window_title

let buttons hs = hs.buttons

let subscreens hs = hs.subscreens

let get_home_screen_from_json json =
  let hs_json = json |> member "home_screen" in
  let button_assoc_lst =
    hs_json |> member "buttons" |> Button.get_buttons_from_json
  in
  let subscreen_assoc_lst =
    hs_json |> member "subscreens" |> Subscreen.get_subscreens_from_json
  in
  {
    x_coord = hs_json |> member "x_coord" |> to_int;
    y_coord = hs_json |> member "y_coord" |> to_int;
    width = hs_json |> member "width" |> to_int;
    height = hs_json |> member "height" |> to_int;
    window_title = hs_json |> member "window_title" |> to_string;
    background_image = hs_json |> member "image_name" |> to_string;
    number_players = 0;
    current_character_selected = "";
    selected_characters = [];
    buttons = SM.of_lst button_assoc_lst SM.empty;
    subscreens = SM.of_lst subscreen_assoc_lst SM.empty;
  }

let dim_button_response hs btn_key subscreen_key =
  let subscreen = SM.find subscreen_key hs.subscreens in
  let btn_map = Subscreen.buttons subscreen in
  let button = SM.find btn_key btn_map in
  let dimmed_btn = Button.dim button in
  let reactivated_buttons = SM.map (fun v -> Button.undim v) btn_map in
  let new_btns = SM.add btn_key dimmed_btn reactivated_buttons in
  let new_sub = Subscreen.replace_buttons subscreen new_btns in
  let new_subscreens = SM.add subscreen_key new_sub hs.subscreens in
  { hs with subscreens = new_subscreens }

let new_response_to_num_players_button hs btn_key subscreen_key number =
  let dimmed_btn_hs = dim_button_response hs btn_key subscreen_key in
  { dimmed_btn_hs with number_players = number }

let new_response_to_start_button hs =
  let s = SM.find Constants.number_players_popup hs.subscreens in
  let activated_s = Subscreen.activate s in
  let new_screens =
    SM.add Constants.number_players_popup activated_s hs.subscreens
  in
  { hs with subscreens = new_screens }

let new_response_to_okay_button hs =
  match hs.number_players = 0 with
  | false ->
      let num_players_screen =
        SM.find Constants.number_players_popup hs.subscreens
      in
      let deactivated_num_player =
        Subscreen.deactivate num_players_screen
      in
      let select_character_screen =
        SM.find Constants.select_character_popup hs.subscreens
      in
      let activated_select_character =
        Subscreen.activate select_character_screen
      in
      let subscreens' =
        SM.add Constants.select_character_popup
          activated_select_character hs.subscreens
      in
      let subscreens'' =
        SM.add Constants.number_players_popup deactivated_num_player
          subscreens'
      in
      { hs with subscreens = subscreens'' }
  | true -> hs

let new_response_to_character_button hs btn_key subscreen_key =
  let subscreen = SM.find subscreen_key hs.subscreens in
  let btn_map = Subscreen.buttons subscreen in
  let button = SM.find btn_key btn_map in
  let dimmed_btn = Button.dim button in
  let reactivated_unselected_chars =
    SM.mapi
      (fun k v ->
        if List.exists (fun x -> x = k) hs.selected_characters then
          Button.dim v
        else Button.undim v)
      btn_map
  in
  let new_btns =
    SM.add btn_key dimmed_btn reactivated_unselected_chars
  in
  let new_sub = Subscreen.replace_buttons subscreen new_btns in
  let new_subscreens = SM.add subscreen_key new_sub hs.subscreens in
  {
    hs with
    subscreens = new_subscreens;
    current_character_selected = btn_key;
  }

let new_response_to_char_okay_button hs =
  let selected_chars =
    hs.current_character_selected :: hs.selected_characters
  in
  match List.length selected_chars = hs.number_players with
  | true -> ProceedToGS
  | false ->
      let subscreen =
        SM.find Constants.select_character_popup hs.subscreens
      in
      let d_image_map = Subscreen.images subscreen in
      let number_chars_images =
        SM.find Constants.select_char_dynamic_image d_image_map
      in
      let wiped = Dynamic_image.clear_images number_chars_images in
      let new_number_image =
        Dynamic_image.add_image wiped (List.length selected_chars + 1)
      in
      let new_d_images =
        SM.add Constants.select_char_dynamic_image new_number_image
          d_image_map
      in
      let new_subscreen =
        Subscreen.replace_images subscreen new_d_images
      in
      let new_subscreens =
        SM.add Constants.select_character_popup new_subscreen
          hs.subscreens
      in
      NewHS
        ( {
            hs with
            selected_characters = selected_chars;
            subscreens = new_subscreens;
          },
          true )

let new_check_button_clicked_aux bmap (x, y) =
  SM.fold
    (fun n b init ->
      if Button.is_clicked b (x, y) then Some n else init)
    bmap None

let new_get_buttons hs =
  let main_buttons = hs.buttons in
  let subscreens = hs.subscreens in
  let active_subscreen =
    SM.fold
      (fun _ s init -> if Subscreen.active s then Some s else init)
      subscreens None
  in
  match active_subscreen with
  | None -> main_buttons
  | Some s -> Subscreen.buttons s

let check_button_click_and_respond hs (x, y) =
  let buttons = new_get_buttons hs in
  let clicked_button = new_check_button_clicked_aux buttons (x, y) in
  match clicked_button with
  | None -> NoButtonClicked
  | Some btn_name -> (
      match btn_name with
      | s when s = Constants.start_button ->
          NewHS (new_response_to_start_button hs, false)
      | s when s = Constants.two_players_button ->
          print_int 2;
          NewHS
            ( new_response_to_num_players_button hs btn_name
                Constants.number_players_popup 2,
              false )
      | s when s = Constants.four_players_button ->
          NewHS
            ( new_response_to_num_players_button hs btn_name
                Constants.number_players_popup 4,
              false )
      | s when s = Constants.six_players_button ->
          NewHS
            ( new_response_to_num_players_button hs btn_name
                Constants.number_players_popup 6,
              false )
      | s when s = Constants.num_players_okay_button ->
          NewHS (new_response_to_okay_button hs, true)
      | s when s = Constants.character_one_button ->
          NewHS
            ( new_response_to_character_button hs btn_name
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_two_button ->
          NewHS
            ( new_response_to_character_button hs btn_name
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_three_button ->
          NewHS
            ( new_response_to_character_button hs btn_name
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_four_button ->
          NewHS
            ( new_response_to_character_button hs btn_name
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_five_button ->
          NewHS
            ( new_response_to_character_button hs btn_name
                Constants.select_character_popup,
              false )
      | s when s = Constants.character_six_button ->
          NewHS
            ( new_response_to_character_button hs btn_name
                Constants.select_character_popup,
              false )
      | s when s = Constants.select_char_okay_button ->
          new_response_to_char_okay_button hs
      | _ -> failwith "TODO")