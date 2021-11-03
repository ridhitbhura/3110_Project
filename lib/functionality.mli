val roll_dice : 'a -> int
(** Rolls a dice from the range of 0 to 12 *)

val handle2 : int -> int
(** Ensures that the dice does not roll a value lower than 2. If so,
    then it re rolls the dice*)