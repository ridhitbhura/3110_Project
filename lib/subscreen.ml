open Yojson.Basic.Util
open Maps

type button_map = Button.t SM.t

type image_map = Dynamic_image.t SM.t

type t = {
  name : string;
  active : bool;
  x_coord : int;
  y_coord : int;
  image_name : string;
  buttons : button_map;
  images : image_map;
}

let active s = s.active

let activate s = { s with active = true }

let activates smap = SM.mapi (fun _ v -> activate v) smap

let deactivate s = { s with active = false }

let deactivates smap = SM.mapi (fun _ v -> deactivate v) smap

let name s = s.name

let x_coord s = s.x_coord

let y_coord s = s.y_coord

let image s = s.image_name

let buttons s = s.buttons

let images s = s.images

let replace_buttons s btn_map = { s with buttons = btn_map }

let replace_images s img_map = { s with images = img_map }

let get_subscreen_from_json json =
  let name = json |> member "name" |> to_string in
  let button_assoc_lst =
    json |> member "buttons" |> Button.get_buttons_from_json
  in
  let images_assoc_lst =
    json |> member "dynamic_images"
    |> Dynamic_image.get_images_from_json
  in
  ( name,
    {
      name;
      active = false;
      x_coord = json |> member "x_coord" |> to_int;
      y_coord = json |> member "y_coord" |> to_int;
      image_name = json |> member "image_name" |> to_string;
      images = SM.of_lst images_assoc_lst SM.empty;
      buttons = SM.of_lst button_assoc_lst SM.empty;
    } )

let get_subscreens_from_json json =
  json |> to_list |> List.map get_subscreen_from_json