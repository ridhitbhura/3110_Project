open Yojson.Basic.Util

type t = {
  name : string;
  image : string;
  image_path : string;
  button : Button.t;
  x_coord : int;
  y_coord : int;
}

let roll_die _ = 1 + Random.int 6

let image d = d.image

let new_image d i =
  { d with image = d.image_path ^ string_of_int i ^ ".png" }

let button d = d.button

let x_coord d = d.x_coord

let y_coord d = d.y_coord

let get_die_from_json json =
  let name = json |> member "name" |> to_string in
  let _, button =
    json |> member "button" |> Button.get_button_from_json
  in
  {
    name;
    image = json |> member "image" |> to_string;
    image_path = json |> member "image_path" |> to_string;
    button;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
  }

let get_dice_from_json json =
  json |> to_list |> List.map get_die_from_json
