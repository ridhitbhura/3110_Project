type t
(**The abstract data type representing a subscreen.*)

val active : t -> bool
(**[active s] is whether the current subscreen is active and being
   displayed.*)

val activate : t -> t
(**[activate s] is [s] activated.*)

val activates : t list -> t list
(**[activates subscreens] is all [subscreens] activated.*)

val deactivate : t -> t
(**[deactivate s] is [s] activated.*)

val deactivates : t list -> t list
(**[deactivates subscreens] is all [s] deactivated.*)

val name : t -> string
(**[name s] is the name of the subscreen*)

val x_coord : t -> int
(**[x_coord s] is the x coordinate location of the [s].*)

val y_coord : t -> int
(**[y_coord s] is the y coordinate location of the [s].*)

val image : t -> string
(**[image s] is the name of the main image of the [s] *)

val images : t -> Dynamic_image.t list
(**[images s] is the list of dynamic images on the [s].*)

val buttons : t -> Button.t list
(**[buttons s] is the list of buttons on the [s].*)

val get_subscreen_from_json : Yojson.Basic.t -> t

val get_subscreens_from_json : Yojson.Basic.t -> t list
