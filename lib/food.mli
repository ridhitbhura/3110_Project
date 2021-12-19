type t
(**The abstract data type representing food.*)

val name : t -> string

val health : t -> int
(**[health food] is the amount of health that [food] regenerates. *)

val image : t -> string
(**[image food] is the name of the food image.*)

val get_food_from_json : Yojson.Basic.t -> t
(**[get_food_from_json json] is a food item constructed from [json].*)

val get_foods_from_json : Yojson.Basic.t -> t list
(**[get_foods_from_json json] is a list of food item constructed from
   [json].*)
