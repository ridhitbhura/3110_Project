open Game

let file = Yojson.Basic.from_file "data/standard.json"

let hs = Home_screen.get_home_screen_from_json file

let gs = Game_screen.get_game_screen_from_json file

let rec check_pop_ups pop_ups p_name =
  match pop_ups with
  | [] -> None
  | h :: t ->
      if Subscreen.name h = p_name then Some h
      else check_pop_ups t p_name

let rec button_repsponse c_list button_name =
  match c_list with
  | [] -> None
  | h :: t ->
      if fst h = button_name then Some (snd h)
      else button_repsponse t button_name

let rec filter name subscreens =
  match subscreens with
  | [] -> []
  | h :: t ->
      if Subscreen.name h <> name then h :: filter name t
      else filter name t

let pop_up_action btn =
  let p_name = button_repsponse Constants.hs_buttons_to_popups btn in
  let pop_up =
    match p_name with
    | None -> None
    | Some p -> check_pop_ups (Home_screen.popups hs) p
  in

  match pop_up with
  | None -> ()
  | Some pop_up ->
      let activated_pop = Subscreen.activate pop_up in
      let subscreen_list =
        filter (Subscreen.name pop_up) (Home_screen.popups hs)
      in
      let updated_subscreens = activated_pop :: subscreen_list in
      let new_hs = Home_screen.change_popups hs updated_subscreens in
      Gui.draw_home_screen new_hs

let rec update_home_screen_new _ =
  let coords = Command.mouse_click () in
  let button = Home_screen.check_button_clicked hs coords in
  match button with
  | None -> update_home_screen_new ()
  | Some btn ->
      if btn = Constants.start_button then pop_up_action btn
      else update_home_screen_new ()

let rec update_home_screen _ =
  let coords = Command.mouse_click () in
  let button = Home_screen.check_button_clicked hs coords in
  match button with
  | None -> update_home_screen ()
  | Some btn ->
      if btn = Constants.start_button then Gui.draw_game_screen gs
      else update_home_screen ()

let run_game _ =
  Gui.initialize_window hs;
  Gui.draw_home_screen hs;
  update_home_screen_new ();
  Command.press_button 'c'

let _ = run_game ()
