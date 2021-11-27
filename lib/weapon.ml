type t = {
  damage : int;
  image_name : string;
}

let damage wpn = wpn.damage

let image wpn = wpn.image_name

let make dmg img = { damage = dmg; image_name = img }
