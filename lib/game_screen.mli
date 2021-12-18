open Maps

type button_map = Button.t SM.t

type subscreen_map = Subscreen.t SM.t

type player_map = Player.t IM.t

type property_map = Property.t IM.t

type food_stack_map = Food_stack.t IM.t

type weapon_stack_map = Weapon_stack.t IM.t

type action_space_map = Action_space.t IM.t

type t
(**The abstract data type representing a game screen.*)

val buttons : t -> button_map

val players : t -> player_map

val properties : t -> property_map

val food_stacks : t -> food_stack_map

val weapon_stacks : t -> weapon_stack_map

val action_spaces : t -> action_space_map

val subscreens : t -> subscreen_map

val team_info : t -> subscreen_map

val info_cards : t -> Subscreen.t

val background_image : t -> string

val background_xcoord : t -> int

val background_ycoord : t -> int

val gameboard_image : t -> string

val gameboard_xcoord : t -> int

val gameboard_ycoord : t -> int

val dice : t -> Die.t list

val curr_player : t -> int

val get_game_screen_from_json : Yojson.Basic.t -> t

val get_order_list_from_json : Yojson.Basic.t -> int * (int * int)

val initialize : t -> int list -> t

type response =
  | EndGame
  | NewGS of t
  | ClosingGS of t * t
  | AnimatePlayerGS of t * int * int

type animation_response =
  | InProgress of t
  | Finished of t

val move_player : t -> int -> int -> animation_response

val respond_to_click : t -> int * int -> response

val new_respond_to_click : t -> int * int -> response

val next_turn_popup : t -> t

val activate_team_selection : t -> t

val assign_players_faction : t -> t

val initialize_team_info : t -> t