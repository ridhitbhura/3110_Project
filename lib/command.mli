val press_button : char -> unit
(**[press_button c] waits until c has been entered on to the keyboard
   before proceeding.*)

val mouse_click : unit -> int * int
(**[mouse_click u] if a user clicks their mouse returns the x and y
   position of their click.*)
