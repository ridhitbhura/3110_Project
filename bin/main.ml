open Game

let file = Yojson.Basic.from_file "data/standard.json"

(*[base_hs] is the static home screen that will not be changed, used for
  redrawing purposes.*)
let base_hs = Home_screen.get_home_screen_from_json file

let hs = Home_screen.get_home_screen_from_json file

let base_gs = Game_screen.get_game_screen_from_json file

let gs = Game_screen.get_game_screen_from_json file

(**[redraw_hs_and_sleep _] draws the base home screen and then sleeps
   the system for [0.5] seconds. *)
let redraw_hs_and_sleep () =
  Gui.draw_home_screen base_hs;
  Unix.sleepf 0.5

let draw_gs_with_turn gs =
  Gui.draw_game_screen gs;
  Unix.sleepf 1.0

(**[update_home_screen _] checks for a mouse click and updates home
   screen based upon that mouse click. If the mouse click caused a
   change on the home screen, the home screen is redrawn.*)
let rec update_home_screen hs =
  let coords = Gui.mouse_click () in
  match Home_screen.respond_to_click hs coords with
  | NoButtonClicked -> update_home_screen hs
  | NewHS (new_hs, sleep) ->
      let _ = if sleep then redraw_hs_and_sleep () else () in
      Gui.draw_home_screen new_hs;
      update_home_screen new_hs
  | ProceedToGS chars -> (
      let gs = Game_screen.initialize gs chars in
      let gs_with_turn =
        Game_screen.initialize gs chars |> Game_screen.next_turn_popup
      in
      match gs_with_turn with
      | EndGame -> failwith "not possible"
      | NewGS turn_gs ->
          draw_gs_with_turn turn_gs;
          Gui.draw_game_screen gs;
          update_game_screen gs)
(* | _ -> failwith "no initial popup" *)

and update_game_screen gs =
  let coords = Gui.mouse_click () in
  match Game_screen.new_respond_to_click gs coords with
  | EndGame -> redraw_hs_and_sleep ()
  | NewGS new_gs -> match (Game_screen.curr_player gs = Game_screen.curr_player new_gs) with
        | true -> Gui.draw_game_screen new_gs; update_game_screen new_gs
        | false -> let gs_with_turn = Game_screen.next_turn_popup new_gs in 
          match gs_with_turn with 
          | EndGame -> failwith "not possible"
          | NewGS turn_gs -> 
            draw_gs_with_turn turn_gs;
            Gui.draw_game_screen new_gs;
            update_game_screen new_gs

(**[run_game _] initializes a new empty Gui window, draws the home
   screen, and continually updates the home screen.*)
let run_game _ =
  Gui.initialize_window hs;
  Gui.draw_home_screen hs;
  update_home_screen hs;
  Gui.press_button 'c'

let _ = run_game ()
