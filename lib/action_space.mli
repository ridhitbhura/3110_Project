type t
(**The abstract type representing an action space, a space on the game
   board that may give a player money, take money, take health, or
   transport the player to a new board location. On the Monopoly board,
   this corresponds to the luxury tax location, go to jail location, and
   more.*)

val name : t -> string

val money : t -> int

val take_health : t -> int
(**[take_health a] is the amount of health this action space takes from
   a player who lands on it.*)

val new_board_location : t -> int
(**[new_board_location a] is the new board location a player should be
   moved to after landing upon this action space.*)

val board_order : t -> int
(**[board_order a] gives the location of this [a] on the game board.*)

val get_action_space_from_json : Yojson.Basic.t -> int * t
(**[get_action_space_from_json js] is the action space that [js]
   represents along with its identifier, its board location.*)

val get_action_spaces_from_json : Yojson.Basic.t -> (int * t) list
(**[get_action_space_from_json js] is a list of action space that [js]
   represents along with their identifiers, their board locations.*)
