open Game

let file = Yojson.Basic.from_file "data/standard.json"

let base_hs = Home_screen.get_home_screen_from_json file

let hs = ref (Home_screen.get_home_screen_from_json file)

let gs = ref (Game_screen.get_game_screen_from_json file)

let rec update_home_screen_new _ =
  let coords = Command.mouse_click () in
  match Home_screen.check_button_click_and_respond !hs coords with
  | NoButtonClicked -> update_home_screen_new ()
  | Response (new_hs, sleep) ->
      let _ =
        if sleep then (
          Gui.draw_home_screen base_hs;
          print_int 1;
          Unix.sleepf 0.5)
        else ()
      in
      Gui.draw_home_screen new_hs;
      hs := new_hs;
      update_home_screen_new ()
  | ProceedToGS -> Gui.draw_game_screen !gs

let run_game _ =
  Gui.initialize_window !hs;
  Gui.draw_home_screen !hs;
  update_home_screen_new ();
  Command.press_button 'c'

let _ = run_game ()
