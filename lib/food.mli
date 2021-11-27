type t
(**The abstract data type representing food.*)

val health : t -> int
(**[health food] is the amount of health that [food] regenerates. *)

val image : t -> string
(**[image food] is the name of the food image.*)

val make : int -> string -> t
(**[make health img] is a food item with the given health and image
   name.*)
