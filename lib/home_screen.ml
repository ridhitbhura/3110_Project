open Yojson.Basic.Util

type t = {
  x_coord : int;
  y_coord : int;
  background_image : string;
  buttons : Button.t list;
  pop_ups : Popup.t list;
}

let image hs = hs.background_image

let x_coord hs = hs.x_coord

let y_coord hs = hs.y_coord

let popups hs = hs.pop_ups

let buttons hs = hs.buttons

let get_home_screen_from_json (json : Yojson.Basic.t) : t =
  let hs_json = json |> member "home_screen" in
  {
    x_coord = hs_json |> member "x_coord" |> to_int;
    y_coord = hs_json |> member "y_coord" |> to_int;
    background_image = hs_json |> member "image_name" |> to_string;
    buttons =
      hs_json |> member "buttons" |> Button.get_buttons_from_json;
    pop_ups = hs_json |> member "pop_ups" |> Popup.get_pop_ups_from_json;
  }
