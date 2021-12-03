val img_path : string -> string

val draw_img : string -> int -> int -> unit

val draw_home_screen : Gameboard.game -> unit

(* val draw_properties : (string * int * int) list -> unit

   val draw_game_screen : (string * int * int) list -> (string * int *
   int) list -> unit *)
val draw_game_screen_background : Gameboard.game -> unit

val draw_gameboard : Gameboard.game -> unit

val draw_dice : Gameboard.game -> unit

val draw_factions : Gameboard.game -> unit

val draw_info_cards : Gameboard.game -> unit

val press_button : char -> unit

val draw_buttons : Gameboard.button list -> unit

val draw_dice_roll : int * int -> Gameboard.game -> unit

(*EVERYTHING BELOW IS NEW GUI STUFF*)

val draw_new_button : Button.t -> unit

val draw_popup : Popup.t -> unit

val draw_new_buttons : Button.t list -> unit

val draw_new_home_screen : Home_screen.t -> unit