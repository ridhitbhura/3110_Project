open Yojson.Basic.Util

type t = {
  x_coord : int;
  y_coord : int;
  image : string;
  buttons : Button.t list;
  pop_ups : Popup.t list;
}

let from_json (json : Yojson.Basic.t) : t =
  {
    x_coord = json |> member "home_screen" |> member "x_coord" |> to_int;
    y_coord = json |> member "home_screen" |> member "y_coord" |> to_int;
    image =
      json |> member "home_screen" |> member "image_name" |> to_string;
    buttons = Button.get_buttons_from_json json "game_screen";
    pop_ups = Popup.get_pop_ups_from_json json "game_screen";
  }
