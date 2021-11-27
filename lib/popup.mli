type t
(**The abstract data type representing a popup window.*)

val x_coord : t -> int
(**[x_coord popup] is the x coordinate location of the [popup].*)

val y_coord : t -> int
(**[y_coord popup] is the y coordinate location of the [popup].*)

val image : t -> string
(**[image popup] is the name of the image of the [popup] *)

val buttons : t -> Button.t list
(**[buttons popup] is the list of buttons on the [popup].*)