type t

val x_coord : t -> int

val y_coord : t -> int

val image : t -> int -> string

val get_image_from_json : Yojson.Basic.t -> t

val get_images_from_json : Yojson.Basic.t -> t list
