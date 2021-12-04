type t

val roll_die : t -> int
(** [roll_die d] is the result of rolling a six-sided die. *)

val image : t -> int -> string
(**[image die i] is the die image with [i] dots. Requires: [i] is
   between 1 and 6 inclusive.*)

val button : t -> Button.t
(**[button d] is the button that corresponds to this die.*)

val get_die_from_json : Yojson.Basic.t -> t
(**[die_from_json j] is the die that [j] represents.*)

val get_dice_from_json : Yojson.Basic.t -> t list
(**[dice_from_json j] is the dice that [j] represents.*)