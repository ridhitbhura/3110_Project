type t
(**The abstract data type representing a weapon stack, a location on the
   board that gives a player who lands upon it a weapon.*)

val generate_weapon : t -> Weapon.t
(**[generate_weapon ws] is a random weapon item.*)

val x_coord : t -> int
(**[x_coord ws] is the x coordinate location of the weapon stack.*)

val y_coord : t -> int
(**[y_coord ws] is the y coordinate location of the weapon stack.*)

val width : t -> int
(**[width ws] is the width of the weapon stack.*)

val height : t -> int
(**[height ws] is the height of the weapon stack.*)

val board_order : t -> int
(**[board_order ws] is the location of weapon stack on the game board.*)

val get_weapon_stack_from_json : Weapon.t list -> Yojson.Basic.t -> t

val get_weapon_stacks_from_json :
  Weapon.t list -> Yojson.Basic.t -> t list
