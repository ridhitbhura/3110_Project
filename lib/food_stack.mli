type t
(**The abstract data type representing a food stack, a location on the
   board that gives a player who lands upon it a food to consume.*)

val generate_food : t -> Food.t
(**[generate_food fs] is a random food item.*)

val x_coord : t -> int
(**[x_coord fs] is the x coordinate location of the food stack.*)

val y_coord : t -> int
(**[y_coord fs] is the y coordinate location of the food stack.*)

val width : t -> int
(**[width fs] is the width of the food stack.*)

val height : t -> int
(**[height fs] is the height of the food stack.*)

val board_order : t -> int
(**[board_order fs] is the location of food stack on the game board.*)

val get_food_stack_from_json : Food.t list -> Yojson.Basic.t -> int * t
(**[get_food_stack_from_json j] is the food stack that [j] rerepsents
   along with its identifier, a board location.*)

val get_food_stacks_from_json :
  Food.t list -> Yojson.Basic.t -> (int * t) list
(**[get_food_stacks_from_json j] are the food stacks that [j] rerepsents
   along with their identifier, their board locations.*)
