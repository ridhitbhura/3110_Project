open Yojson.Basic.Util

type t = {
  name : string;
  image_path : string;
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
}

let x_coord img = img.x_coord

let y_coord img = img.y_coord

let image img x = img.image_path ^ string_of_int x ^ ".png"

let get_image_from_json json =
  {
    name = json |> member "name" |> to_string;
    image_path = json |> member "image_path" |> to_string;
    x_coord = json |> member "x_coord" |> to_int;
    y_coord = json |> member "y_coord" |> to_int;
    width = json |> member "width" |> to_int;
    height = json |> member "height" |> to_int;
  }

let get_images_from_json json =
  json |> to_list |> List.map get_image_from_json
