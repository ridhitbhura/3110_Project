open Yojson.Basic.Util

type t = {
  x_coord : int;
  y_coord : int;
  image_name : string;
  images : string list;
  buttons : Button.t list;
}

let x_coord p = p.x_coord

let y_coord p = p.y_coord

let pop_up_image p = p.image_name

let images p = p.images

let buttons p = p.buttons

let get_pop_up_from_json json =
  let x_coord = json |> member "x_coord" |> to_int in
  let y_coord = json |> member "y_coord" |> to_int in
  let img = json |> member "image_name" |> to_string in
  let images =
    json |> member "images" |> to_list |> List.map to_string
  in
  let buttons = Button.get_buttons_from_json json "button_list" in
  { x_coord; y_coord; image_name = img; images; buttons }

let get_pop_ups_from_json json screen =
  json |> member screen |> member "pop_ups" |> to_list
  |> List.map get_pop_up_from_json
