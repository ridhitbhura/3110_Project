type t
(**The abstract data type representing a dynamic image. A dynamic image
   represents a collection of images, it could hold zero images or 5
   images. Each image inside the collection has the same width and
   height.*)

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

val add_image : t -> int -> t
(**[add_image dynamic_image x] adds the image associated with integer
   [x] to the list of images stored in the dynamic image.*)

val get_image_from_json : Yojson.Basic.t -> t

val get_images_from_json : Yojson.Basic.t -> t list
