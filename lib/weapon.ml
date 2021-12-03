open Yojson.Basic.Util

type t = {
  name : string;
  damage : int;
  image_name : string;
}

let damage wpn = wpn.damage

let image wpn = wpn.image_name

let get_weapon_from_json json =
  {
    name = json |> member "name" |> to_string;
    damage = json |> member "damage" |> to_int;
    image_name = json |> member "image_name" |> to_string;
  }

let get_weapons_from_json json =
  json |> to_list |> List.map get_weapon_from_json