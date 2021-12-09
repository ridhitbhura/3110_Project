type t
(**The abstract data type representing a game screen.*)

val buttons : t -> Button.t list

val players : t -> Player.t list

val properties : t -> Property.t list

val food_stacks : t -> Food_stack.t list

val weapon_stacks : t -> Weapon_stack.t list

val action_spaces : t -> Action_space.t list

val pop_ups : t -> Subscreen.t list

val team_info : t -> Subscreen.t list

val info_cards : t -> Subscreen.t

val background_image : t -> string

val background_xcoord : t -> int

val background_ycoord : t -> int

val gameboard_image : t -> string

val gameboard_xcoord : t -> int

val gameboard_ycoord : t -> int

val dice : t -> Die.t list

val get_game_screen_from_json : Yojson.Basic.t -> t