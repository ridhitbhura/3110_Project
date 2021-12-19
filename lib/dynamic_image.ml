open Yojson.Basic.Util

type t = {
  images : string list;
  image_path : string;
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
}

let x_coord d = d.x_coord

let y_coord d = d.y_coord

let width d = d.width

let height d = d.height

let images d = d.images

let clear_images d = { d with images = [] }

let add_image d x =
  {
    d with
    images = (d.image_path ^ string_of_int x ^ ".png") :: d.images;
  }

let rec add_images d x =
  match x with
  | x when x >= 10 ->
      let remainder = x mod 10 in
      let divided = x / 10 in
      add_images (add_image d remainder) divided
  | x when x < 10 -> add_image d x
  | _ -> d

let get_image_from_json json =
  let name = json |> member "name" |> to_string in
  ( name,
    {
      images = json |> member "images" |> to_list |> List.map to_string;
      image_path = json |> member "image_path" |> to_string;
      x_coord = json |> member "x_coord" |> to_int;
      y_coord = json |> member "y_coord" |> to_int;
      width = json |> member "width" |> to_int;
      height = json |> member "height" |> to_int;
    } )

let get_images_from_json json =
  json |> to_list |> List.map get_image_from_json