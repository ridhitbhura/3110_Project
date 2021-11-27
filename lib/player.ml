type fac =
  | Stripes
  | Solids

type t = {
  x_coord : int;
  y_coord : int;
  image_name : string;
  weapon : Weapon.t option;
  money : int;
  health : int;
  board_location : int;
  properties : Property.t list;
  faction : fac;
}

let x_coord player = player.x_coord

let y_coord player = player.y_coord

let image player = player.image_name

let health player = player.health

let update_health player amt = { player with health = amt }

let money player = player.money

let update_money player amt = { player with money = amt }

let location player = player.board_location

let move_board player loc = { player with board_location = loc }

let move_coord player x y = { player with x_coord = x; y_coord = y }

let properties player = player.properties

let obtain_property player property =
  { player with properties = property :: player.properties }

let has_weapon player =
  match player.weapon with
  | None -> false
  | Some _ -> true

let weapon_damage player =
  match player.weapon with
  | None -> failwith "Player has no weapon"
  | Some wpn -> Weapon.damage wpn

let obtain_weapon player wpn = { player with weapon = wpn }

let faction player = player.faction

type init = {
  image_name : string;
  x_coord : int;
  y_coord : int;
  money : int;
  health : int;
  faction : fac;
}

let make i =
  {
    x_coord = i.x_coord;
    y_coord = i.y_coord;
    image_name = i.image_name;
    weapon = None;
    money = i.money;
    health = i.health;
    board_location = 0;
    properties = [];
    faction = i.faction;
  }
