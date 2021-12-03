type t
(**The abstract data type representing a popup window.*)

val active : t -> bool
(**[active popup] is whether the current popup is active and being
   displayed.*)

val activate : t -> t
(**[activate popup] is [popup] activated.*)

val deactivate : t -> t
(**[deactivate popup] is [popup] activated.*)

val x_coord : t -> int
(**[x_coord popup] is the x coordinate location of the [popup].*)

val y_coord : t -> int
(**[y_coord popup] is the y coordinate location of the [popup].*)

val image : t -> string
(**[image popup] is the name of the main image of the [popup] *)

val images : t -> Dynamic_image.t list
(**[images popup] is the list of dynamic images on the [popup].*)

val buttons : t -> Button.t list
(**[buttons popup] is the list of buttons on the [popup].*)

val get_pop_up_from_json : Yojson.Basic.t -> t

val get_pop_ups_from_json : Yojson.Basic.t -> t list
