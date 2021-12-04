open Graphics

let img_path img_name = "images/" ^ img_name

let draw_img img_name x_coord y_coord =
  let path = img_path img_name in
  let img = Png.load_as_rgb24 path [] in
  let g = Graphic_image.of_image img in
  Graphics.draw_image g x_coord y_coord

(* let dimension_check mouse img_dim x y = if fst mouse > x - (fst
   img_dim / 2) && fst mouse < x + (fst img_dim / 2) && snd mouse > y -
   (snd img_dim / 2) && snd mouse > y - (snd img_dim / 2) then true else
   false

   let rec is_dice_clicked img_dim game = let dice1_x =
   game.game_screen.dice.dice1.x_coord in let dice1_y =
   game.game_screen.dice.dice1.y_coord in let dice2_x =
   game.game_screen.dice.dice2.x_coord in let dice2_y =
   game.game_screen.dice.dice2.y_coord in if button_down () then if
   dimension_check (mouse_pos ()) img_dim dice1_x dice1_y ||
   dimension_check (mouse_pos ()) img_dim dice2_x dice2_y then handle2 0
   else is_dice_clicked img_dim game else is_dice_clicked img_dim game

   let draw_dice_roll img_dim game = (* let x =
   game.game_screen.dice.x_coord + 50 in let y =
   game.game_screen.dice.y_coord + 50 in *) let z = is_dice_clicked
   img_dim game in let img = string_of_int z in draw_string img *)

let draw_button b =
  match Button.image b with
  | None -> ()
  | Some img ->
      let x = Button.x_coord b in
      let y = Button.y_coord b in
      draw_img img x y

let rec draw_buttons lst =
  match lst with
  | [] -> ()
  | h :: t ->
      draw_button h;
      draw_buttons t

let draw_popup p =
  let img = Popup.image p in
  let x = Popup.x_coord p in
  let y = Popup.y_coord p in
  draw_img img x y;
  let buttons = Popup.buttons p in
  draw_buttons buttons

let rec draw_popups lst =
  match lst with
  | [] -> ()
  | h :: t ->
      draw_popup h;
      draw_popups t

let initialize_window name width height =
  open_graph "";
  resize_window width height;
  set_window_title name

let draw_home_screen hs =
  let img = Home_screen.image hs in
  let x = Home_screen.x_coord hs in
  let y = Home_screen.y_coord hs in
  draw_img img x y;
  let buttons = Home_screen.buttons hs in
  draw_buttons buttons