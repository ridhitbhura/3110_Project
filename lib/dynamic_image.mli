type t
(**The abstract data type representing a dynamic image. A dynamic image
   represents a collection of images. Each image inside the collection
   has the same width and height.*)

val x_coord : t -> int
(**[x_coord i] gives the x_coord of the dynamic image.*)

val y_coord : t -> int
(**[y_coord i] gives the x_coord of the dynamic image.*)

val width : t -> int
(**[width i] gives the width of each of the dynamic image.*)

val height : t -> int
(**[height i] gives the height of each of the dynamic image.*)

val images : t -> string list
(**[images i] gives the list of images stored in the dynamic image.*)

val clear_images : t -> t
(**[clear_images i] is the dynamic image with an empty image collection.*)

val add_image : t -> int -> t
(**[add_image dynamic_image x] adds the image associated with integer
   [x] to the collection of images stored in the dynamic image.*)

val get_image_from_json : Yojson.Basic.t -> string * t
(**[get_image_from_json j] is the dynamic image that [j] represents
   along with its identifier, its name.*)

val get_images_from_json : Yojson.Basic.t -> (string * t) list
(**[get_images_from_json j] is the dynamic image that [j] represents
   along with their identifiers, their names.*)
