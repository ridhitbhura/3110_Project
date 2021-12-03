open Yojson.Basic.Util

type dimen = {
  x_range : int * int;
  y_range : int * int;
}

type status =
  | Active
  | Inactive

type t = {
  name : string;
  dimension : dimen;
  status : status;
  image : string option;
  dimmed_image : string option;
  clicked : bool;
  x_coord : int;
  y_coord : int;
}

let is_clicked b = b.clicked

let click b = { b with clicked = true }

let unclick b = { b with clicked = false }

let is_dimmed b =
  match b.status with
  | Active -> false
  | Inactive -> true

let dim b = { b with status = Inactive }

let undim b = { b with status = Active }

let dimension b = b.dimension

let image b =
  match b.status with
  | Active -> b.image
  | Inactive -> b.dimmed_image

let unwrap_image img = if img = "" then None else Some img

let compute_dimension x_coord y_coord width height =
  let x_range = (x_coord, x_coord + width) in
  let y_range = (y_coord, y_coord + height) in
  { x_range; y_range }

let x_coord b = b.x_coord

let y_coord b = b.y_coord

let get_button_from_json json =
  let x_coord = json |> member "x_coord" |> to_int in
  let y_coord = json |> member "y_coord" |> to_int in
  let width = json |> member "width" |> to_int in
  let height = json |> member "height" |> to_int in
  let i = json |> member "image_name" |> to_string in
  let dimmed_i = json |> member "dimmed_image_name" |> to_string in
  let dimen = compute_dimension x_coord y_coord width height in
  let img = unwrap_image i in
  let dimmed_img = unwrap_image dimmed_i in
  {
    name = json |> member "name" |> to_string;
    dimension = dimen;
    status = Active;
    image = img;
    dimmed_image = dimmed_img;
    clicked = false;
    x_coord;
    y_coord;
  }

let get_buttons_from_json json =
  json |> to_list |> List.map get_button_from_json
