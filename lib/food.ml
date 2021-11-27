type t = {
  health : int;
  image_name : string;
}

let health food = food.health

let image food = food.image_name

let make health img = { health; image_name = img }
