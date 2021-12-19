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
  current_character_selected : string option;
  selected_characters : string list;
}

type hs_response = t * bool

type gs_response = int list

type response =
  | NoButtonClicked
  | NewHS of hs_response
  | ProceedToGS of gs_response

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
    current_character_selected = None;
    selected_characters = [];
    buttons = SM.of_lst button_assoc_lst SM.empty;
    subscreens = SM.of_lst subscreen_assoc_lst SM.empty;
  }

(**[response_to_num_players_button hs btn_key subscreen_key number] is
   the home screen updated to a user selecting the number of players.
   [number] is the number of players selected. [btn_key] is the name of
   the button that was selected. The function first finds the number
   players subscreen. It then gets all buttons from that subcreen, and
   then finds the button that was clicked. It dims that buttons,
   reactivates all other buttons, and adds these buttons back to the
   subscreen.*)
let response_to_num_players_button hs btn_key number =
  let subscreen =
    SM.find Constants.number_players_screen hs.subscreens
  in
  let btn_map = Subscreen.buttons subscreen in
  let button = SM.find btn_key btn_map in
  let dimmed_btn = Button.dim button in
  let reactivated_buttons = SM.map (fun v -> Button.undim v) btn_map in
  let new_btns = SM.add btn_key dimmed_btn reactivated_buttons in
  let new_sub = Subscreen.replace_buttons subscreen new_btns in
  let new_subscreens =
    SM.add Constants.number_players_screen new_sub hs.subscreens
  in
  NewHS
    ( { hs with subscreens = new_subscreens; number_players = number },
      false )

(**[response_to_start_button hs] is the home screen updated in response
   to a user clicking the start button. Namely, the subscreen which asks
   the users how many players there are is activated.*)
let response_to_start_button hs =
  let s = SM.find Constants.number_players_screen hs.subscreens in
  let activated_s = Subscreen.activate s in
  let new_screens =
    SM.add Constants.number_players_screen activated_s hs.subscreens
  in
  NewHS ({ hs with subscreens = new_screens }, false)

(**[response_to_num_players_okay_button hs] is the home screen updated
   in response to a user clicked the "okay" button on the number players
   subscreen. If a user has not yet selected the number of players, the
   home screen remains the same. If a user previously selected some
   number of players, the home screen deactivates the number of players
   screen and activates the select character screen. *)
let response_to_num_players_okay_button hs =
  match hs.number_players = 0 with
  | false ->
      let num_players_screen =
        SM.find Constants.number_players_screen hs.subscreens
      in
      let deactivated_num_player =
        Subscreen.deactivate num_players_screen
      in
      let select_character_screen =
        SM.find Constants.select_character_screen hs.subscreens
      in
      let activated_select_character =
        Subscreen.activate select_character_screen
      in
      let subscreens' =
        SM.add Constants.select_character_screen
          activated_select_character hs.subscreens
      in
      let subscreens'' =
        SM.add Constants.number_players_screen deactivated_num_player
          subscreens'
      in
      NewHS ({ hs with subscreens = subscreens'' }, true)
  | true -> NewHS (hs, false)

(**[response_to_character_button hs] is the home screen updated in
   response to a user choosing a certain character to play as. The
   function first finds the character button pressed within the
   character selection subscreen. That button is then dimmed. The rest
   of the character buttons are reactivated only if they have not been
   previously selected by other players.*)
let response_to_character_button hs btn_key =
  let subscreen =
    SM.find Constants.select_character_screen hs.subscreens
  in
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
  let new_subscreens =
    SM.add Constants.select_character_screen new_sub hs.subscreens
  in
  NewHS
    ( {
        hs with
        subscreens = new_subscreens;
        current_character_selected = Some btn_key;
      },
      false )

(**[match_players_to_characters] takes [character_list] and creates an a
   list, turning each character button name into a character number. *)
let get_character_numbers character_list =
  List.map (fun x -> int_of_string x) character_list

(**[response_to_char_okay_button hs] is the home screen updated in
   response to a player selecting okay on the character selection
   subscreen. If the player did not yet select a character, the home
   screen is not updated (forcing the player to select a character). If
   the player selected a character that was already selected, the home
   screen is not updated. Then, the currently selected character is
   added to the list of selected character. If the number of selected
   character is equal to the number of players, all players have
   selected a character and we must proceed to game screen. Else, we
   must get the select character subscreen. We must update the dynamic
   image which displays the Player number (eg. Player 1 vs Player 2). *)
let response_to_char_okay_button hs =
  match hs.current_character_selected with
  | None -> NewHS (hs, false)
  | Some selected_char -> (
      match List.mem selected_char hs.selected_characters with
      | true -> NewHS (hs, false)
      | false -> (
          let selected_chars =
            selected_char :: hs.selected_characters
          in
          match List.length selected_chars = hs.number_players with
          | true -> ProceedToGS (get_character_numbers selected_chars)
          | false ->
              let subscreen =
                SM.find Constants.select_character_screen hs.subscreens
              in
              let d_image_map = Subscreen.images subscreen in
              let number_chars_images =
                SM.find Constants.select_char_dynamic_image d_image_map
              in
              let wiped =
                Dynamic_image.clear_images number_chars_images
              in
              let new_number_image =
                Dynamic_image.add_image wiped
                  (List.length selected_chars + 1)
              in
              let new_d_images =
                SM.add Constants.select_char_dynamic_image
                  new_number_image d_image_map
              in
              let new_subscreen =
                Subscreen.replace_images subscreen new_d_images
              in
              let new_subscreens =
                SM.add Constants.select_character_screen new_subscreen
                  hs.subscreens
              in
              NewHS
                ( {
                    hs with
                    selected_characters = selected_chars;
                    subscreens = new_subscreens;
                    current_character_selected = None;
                  },
                  true )))

(**[check_button_clicked button_map coords] searched the button map to
   determine if a button was clicked. If no button was clicked, it is
   [None]. Else, it is [Some b], where b is the button that was clicked.*)
let check_button_clicked bmap (x, y) =
  SM.fold
    (fun n b init ->
      if Button.is_clicked b (x, y) then Some n else init)
    bmap None

(**[get_buttons hs] are the currently active buttons. If there are no
   active subcreens, then the active buttons are simply the main buttons
   on the home screen (Start, Credits). If there is an active subscreen,
   the active buttons are all the buttons on that subscreen.*)
let get_buttons hs =
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

let respond_to_click hs (x, y) =
  let buttons = get_buttons hs in
  let clicked_button = check_button_clicked buttons (x, y) in
  match clicked_button with
  | None -> NoButtonClicked
  | Some btn_name -> (
      match btn_name with
      | s when s = Constants.start_button -> response_to_start_button hs
      | s when s = Constants.two_players_button ->
          response_to_num_players_button hs btn_name 2
      | s when s = Constants.four_players_button ->
          response_to_num_players_button hs btn_name 4
      | s when s = Constants.six_players_button ->
          response_to_num_players_button hs btn_name 6
      | s when s = Constants.num_players_okay_button ->
          response_to_num_players_okay_button hs
      | s when s = Constants.character_one_button ->
          response_to_character_button hs btn_name
      | s when s = Constants.character_two_button ->
          response_to_character_button hs btn_name
      | s when s = Constants.character_three_button ->
          response_to_character_button hs btn_name
      | s when s = Constants.character_four_button ->
          response_to_character_button hs btn_name
      | s when s = Constants.character_five_button ->
          response_to_character_button hs btn_name
      | s when s = Constants.character_six_button ->
          response_to_character_button hs btn_name
      | s when s = Constants.select_char_okay_button ->
          response_to_char_okay_button hs
      | _ -> failwith btn_name)