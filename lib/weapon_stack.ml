open Yojson.Basic.Util

type t = {
  board_order : int;
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
  weapons : Weapon.t list;
}

let generate_weapon ws =
  let i = Random.int (List.length ws.weapons) in
  let wpn = List.nth_opt ws.weapons i in
  match wpn with
  | None -> failwith "Impossible"
  | Some wpn -> wpn

let x_coord ws = ws.x_coord

let y_coord ws = ws.y_coord

let width ws = ws.width

let height ws = ws.height

let board_order ws = ws.board_order

let get_weapon_stack_from_json wpns json =
  let board_order = json |> member "board_order" |> to_int in
  ( board_order,
    {
      board_order;
      x_coord = json |> member "x_coord" |> to_int;
      y_coord = json |> member "y_coord" |> to_int;
      width = json |> member "width" |> to_int;
      height = json |> member "height" |> to_int;
      weapons = wpns;
    } )

let get_weapon_stacks_from_json wpns json =
  json |> to_list |> List.map (get_weapon_stack_from_json wpns)
