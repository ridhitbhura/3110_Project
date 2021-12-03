type t
(**The abstract data type representing a weapon.*)

val damage : t -> int
(**[damage wpn] is the amount of damage that [wpn] inflicts.*)

val image : t -> string
(**[image wpn] is the name of the [wpn] image.*)

val get_weapon_from_json : Yojson.Basic.t -> t
(**[get_weapon_from_json json] is a weapon item constructed from [json].*)

val get_weapons_from_json : Yojson.Basic.t -> t list
(**[get_weapons_from_json json] is a list of weapon items constructed
   from [json].*)
