open Yojson.Basic.Util

type t = {
  name : string;
  health : int;
  image_name : string;
}

let health food = food.health

let image food = food.image_name

let get_food_from_json json =
  {
    name = json |> member "name" |> to_string;
    health = json |> member "hp" |> to_int;
    image_name = json |> member "image_name" |> to_string;
  }

let get_foods_from_json json =
  json |> to_list |> List.map get_food_from_json
