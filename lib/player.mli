type fac =
  | Stripes
  | Solids

type t
(** The abstract type of values representing players. *)

val x_coord : t -> int
(**[x_coord player] gives the x-coord of the player on the screen.*)

val y_coord : t -> int
(**[y_coord player] gives the y-coord of the player on the screen.*)

val image : t -> string
(**[image player] gives the name of the image of the player [player].*)

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

val move_board : t -> int -> t
(**[move player loc] moves the player to a new board location [loc].
   Requires: [0 <= loc < 40]*)

val move_coord : t -> int -> int -> t
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

val obtain_weapon : t -> Weapon.t -> t
(**[obtain_weapon player wpn] gives [player] a weapon [wpn].*)

val faction : t -> fac
(**[faction player] is the faction the player is in.*)

type init = {
  image_name : string;
  x_coord : int;
  y_coord : int;
  money : int;
  health : int;
  faction : fac;
}

val make : init -> t
(**[init board] initializes a player.*)