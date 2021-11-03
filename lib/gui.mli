val img_path : string -> string

val draw_img : string -> int -> int -> unit

val draw_home_screen : Gameboard.game -> unit

(* val draw_properties : (string * int * int) list -> unit

   val draw_game_screen : (string * int * int) list -> (string * int *
   int) list -> unit *)
val draw_game_screen_background : Gameboard.game -> unit

val draw_gameboard : Gameboard.game -> unit

val draw_dice : Gameboard.game -> unit

val draw_buttons : Gameboard.game -> unit

val draw_factions : Gameboard.game -> unit

val draw_info_cards : Gameboard.game -> unit

val press_button : char -> unit

val draw_dice_roll : int * int -> Gameboard.game -> unit
