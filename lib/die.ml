open Yojson.Basic.Util

type t = {
  name : string;
  image_path : string;
  button : Button.t;
}

let roll_die _ = 1 + Random.int 6

let image d i = d.image_path ^ string_of_int i ^ ".png"

let button d = d.button

let get_die_from_json json =
  {
    name = json |> member "name" |> to_string;
    image_path = json |> member "image_path" |> to_string;
    button = json |> member "button" |> Button.get_button_from_json;
  }

let get_dice_from_json json =
  json |> to_list |> List.map get_die_from_json
