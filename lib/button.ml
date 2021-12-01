open Yojson.Basic.Util

type dimen = {
  x_range : int * int;
  y_range : int * int;
}

type status =
  | Active
  | Inactive

type t = {
  dimension : dimen;
  status : status;
  image : string;
  dimmed_image : string option;
  clicked : bool;
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

let image b = b.image

let dimmed_image b = b.dimmed_image

type init = {
  x_coord : int;
  y_coord : int;
  width : int;
  height : int;
  image : string;
  dimmed_image : string option;
}

let make i =
  let x_range = (i.x_coord, i.x_coord + i.width) in
  let y_range = (i.y_coord, i.y_coord + i.height) in
  let dimen = { x_range; y_range } in
  {
    dimension = dimen;
    status = Active;
    image = i.image;
    dimmed_image = i.dimmed_image;
    clicked = false;
  }

let get_button_from_json json =
  let x_coord = json |> member "x_coord" |> to_int in
  let y_coord = json |> member "y_coord" |> to_int in
  let width = json |> member "width" |> to_int in
  let height = json |> member "height" |> to_int in
  let image = json |> member "image_name" |> to_string in
  let dim_img = None in
  let init =
    { x_coord; y_coord; width; height; image; dimmed_image = dim_img }
  in
  make init

let get_buttons_from_json json screen =
  json |> member screen |> member "buttons" |> to_list
  |> List.map get_button_from_json
