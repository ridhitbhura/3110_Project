open Yojson.Basic.Util

type t = {
  name : string;
  active : bool;
  x_coord : int;
  y_coord : int;
  image_name : string;
  images : Dynamic_image.t list;
  buttons : Button.t list;
}

let active p = p.active

let activate p = { p with active = true }

let deactivate p = { p with active = false }

let x_coord p = p.x_coord

let y_coord p = p.y_coord

let image p = p.image_name

let images p = p.images

let buttons p = p.buttons

let get_pop_up_from_json json =
  {
    name = json |> member "name" |> to_string;
    active = false;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
    image_name = json |> member "image_name" |> to_string;
    images =
      json |> member "images" |> Dynamic_image.get_images_from_json;
    buttons = json |> member "buttons" |> Button.get_buttons_from_json;
  }

let get_pop_ups_from_json json =
  json |> to_list |> List.map get_pop_up_from_json
