type fac =
  | Stripes
  | Solids
  | Unassigned
      (**[fac] are the different factions that a player can belong to.*)

type status =
  | Active
  | Inactive

type t
(** The abstract type of values representing players. *)

val x_coord : t -> int
(**[x_coord player] gives the x-coord of the player on the screen.*)

val y_coord : t -> int
(**[y_coord player] gives the y-coord of the player on the screen.*)

val small_image : t -> string
(**[small_image player] gives the name of the small image of [player].*)

val medium_image : t -> string
(**[medium_image player] gives the name of the medium image of [player].*)

val large_image : t -> string
(**[large_image player] gives the name of the large image of [player].*)

val health : t -> int
(**[health player] is the current amount of health the player has.*)

val update_health : t -> int -> t
(**[update_health player amt] is [player] with health [amt].*)

val money : t -> int
(**[money player] is the current amount of money the player has.*)

val update_money : t -> int -> t
(**[update_money player amt] is [player] with money [amt].*)

val location : t -> int
(**[location player] gives the board location the player is at
   currently.*)

val move_board : int -> t -> t
(**[move loc player] moves the player to a new board location [loc].
   Requires: [0 <= loc < 40]*)

val move_coord : int -> int -> t -> t
(**[move_coord x y] moves the player on the screen to x coordinate [x]
   and y coordinate [y].*)

val properties : t -> Property.t list
(**[properties player] gives the list of properties the player owns.*)

val obtain_property : t -> Property.t -> t
(**[obtain_property player property] is the [player] that also owns
   [property].*)

val has_weapon : t -> bool
(**[has_weapon player] is whether [player] has a weapon.*)

val weapon_damage : t -> int
(**[weapon_damage player] is the amount of damage that the player's
   weapon inflicts.*)

val obtain_weapon : t -> Weapon.t option -> t
(**[obtain_weapon player wpn] gives [player] a weapon [wpn].*)

val faction : t -> fac
(**[faction player] is the faction the player is in.*)

val update_player_number : t -> int -> t
(**[update_player_number p num] is the player with player number given
   by [num].*)

val character : t -> string
(**[character player] is the character icon that this player holds.*)

val deactivate : t -> t
(**[deactivate player] is the player deactivated.*)

val active : t -> bool
(**[active p] is whether the player is active.*)

val get_player_from_json : Yojson.Basic.t -> int * t
(**[get_player_from_json js] is the player that [js] represents along
   with its identifier, the player number.*)

val get_players_from_json : Yojson.Basic.t -> (int * t) list
(**[get_players_from_json js] is the player that [js] represents along
   with their identifier, the player number.*)
