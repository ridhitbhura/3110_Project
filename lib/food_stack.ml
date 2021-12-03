open Yojson.Basic.Util

type t = {
  board_order : int;
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
  foods : Food.t list;
}

let generate_food fs =
  let i = Random.int (List.length fs.foods) in
  let food = List.nth_opt fs.foods i in
  match food with
  | None -> failwith "Impossible"
  | Some wpn -> wpn

let x_coord fs = fs.x_coord

let y_coord fs = fs.y_coord

let width fs = fs.width

let height fs = fs.height

let board_order fs = fs.board_order

let get_food_stack_from_json fds json =
  {
    board_order = json |> member "board_order" |> to_int;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
    width = json |> member "width" |> to_int;
    height = json |> member "height" |> to_int;
    foods = fds;
  }

let get_food_stacks_from_json fds json =
  json |> to_list |> List.map (get_food_stack_from_json fds)
