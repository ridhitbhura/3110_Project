open Maps

type button_map = Button.t SM.t
(**[button_map] is a type representing a map with keys that are button
   names and values that are buttons.*)

type image_map = Dynamic_image.t SM.t
(**[image_map] is a type representing a map with keys that are image
   names and values that are dynamic images.*)

type t
(**The abstract data type representing a subscreen.*)

val active : t -> bool
(**[active s] is whether the current subscreen is active and being
   displayed.*)

val activate : t -> t
(**[activate s] is [s] activated.*)

val activates : t SM.t -> t SM.t
(**[activates subscreens] is all [subscreens] activated.*)

val deactivate : t -> t
(**[deactivate s] is [s] activated.*)

val deactivates : t SM.t -> t SM.t
(**[deactivates subscreens] is all [s] deactivated.*)

val name : t -> string
(**[name s] is the name of the subscreen*)

val x_coord : t -> int
(**[x_coord s] is the x coordinate location of the [s].*)

val y_coord : t -> int
(**[y_coord s] is the y coordinate location of the [s].*)

val image : t -> string
(**[image s] is the name of the main image of the [s] *)

val buttons : t -> button_map
(**[buttons s] are the buttons inside the subscreen. *)

val images : t -> image_map
(**[images s] are the dynamic images inside the subscreen. *)

val replace_buttons : t -> button_map -> t
(**[replace_buttons s btns] replaces the buttons inside subscreen with
   the given [btns]. *)

val replace_images : t -> image_map -> t
(**[replace_images s imgs] replaces the images inside subscreen with the
   given [imgs]. *)

val get_subscreen_from_json : Yojson.Basic.t -> string * t
(**[get_subscreen_from_json js] is the subscreen that [js] represents
   along with its identifier, the name.*)

val get_subscreens_from_json : Yojson.Basic.t -> (string * t) list
(**[get_subscreens_from_json js] is the subscreen that [js] represents
   along with their identifiers, the name.*)
