open Game

let file = Yojson.Basic.from_file "data/standard.json"

let hs = Home_screen.get_home_screen_from_json file

let gs = Game_screen.get_game_screen_from_json file

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
  update_home_screen ();
  Command.press_button 'c'

let _ = run_game ()
