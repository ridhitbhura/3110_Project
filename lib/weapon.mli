type t
(**The abstract data type representing a weapon.*)

val damage : t -> int
(**[damage wpn] is the amount of damage that [wpn] inflicts.*)

val image : t -> string
(**[image wpn] is the name of the [wpn] image.*)

val make : int -> string -> t
(**[make dmg img] is a weapon with the given damage and image name.*)