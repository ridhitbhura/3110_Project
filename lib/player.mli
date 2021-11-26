type t
(** The abstract type of values representing players. *)

val init : Board.t -> t
(**[init board] initializes a player.*)

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

val move : t -> int -> t
(**[move player loc] moves the player to a new board location [loc].*)

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
(**[obtain_weapon player wpn] is the player *)

val is_in_wardens : t -> bool
(**[is_in_wardens player] is whether or not if the player is currently
   held in the warden's office *)
