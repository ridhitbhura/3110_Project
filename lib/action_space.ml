open Yojson.Basic.Util

type t = {
  name : string;
  board_order : int;
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
  money : int;
  take_hp : int;
  new_board_location : int;
}

let name a = a.name

let money a = a.money

let take_health a = a.take_hp

let new_board_location a = a.new_board_location

let board_order a = a.board_order

let get_action_space_from_json json =
  let board_order = json |> member "board_order" |> to_int in
  ( board_order,
    {
      name = json |> member "name" |> to_string;
      board_order;
      x_coord = json |> member "x_coord" |> to_int;
      y_coord = json |> member "y_coord" |> to_int;
      width = json |> member "width" |> to_int;
      height = json |> member "height" |> to_int;
      money = json |> member "money" |> to_int;
      take_hp = json |> member "take_hp" |> to_int;
      new_board_location = json |> member "new_board_order" |> to_int;
    } )

let get_action_spaces_from_json json =
  json |> to_list |> List.map get_action_space_from_json
