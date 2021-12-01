type t
(**The abstract data type representing a popup window.*)

val x_coord : t -> int
(**[x_coord popup] is the x coordinate location of the [popup].*)

val y_coord : t -> int
(**[y_coord popup] is the y coordinate location of the [popup].*)

val pop_up_image : t -> string
(**[image popup] is the name of the image of the [popup] *)

val images : t -> string list
(**[images popup] is the list of image names on the [popup].*)

val buttons : t -> Button.t list
(**[buttons popup] is the list of buttons on the [popup].*)

val get_pop_up_from_json : Yojson.Basic.t -> t

val get_pop_ups_from_json : Yojson.Basic.t -> string -> t list
