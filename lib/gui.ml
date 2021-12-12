open Graphics
open Maps

let img_path img_name = "images/" ^ img_name

let draw_img img_name x_coord y_coord =
  let path = img_path img_name in
  let img = Png.load_as_rgb24 path [] in
  let g = Graphic_image.of_image img in
  Graphics.draw_image g x_coord y_coord

let rec map_draw draw lst =
  match lst with
  | [] -> ()
  | h :: t ->
      draw h;
      map_draw draw t

let draw_button _ b =
  match Button.image b with
  | None -> ()
  | Some img ->
      let x_coord = Button.x_coord b in
      let y_corrd = Button.y_coord b in
      draw_img img x_coord y_corrd

let draw_buttons bmap = SM.iter draw_button bmap

let rec draw_dynamic_image_aux x_coord y_coord width = function
  | [] -> ()
  | h :: t ->
      draw_img h x_coord y_coord;
      draw_dynamic_image_aux (x_coord + width) y_coord width t

let draw_dynamic_image _ d =
  let width = Dynamic_image.width d in
  let x_coord = Dynamic_image.x_coord d in
  let y_coord = Dynamic_image.y_coord d in
  let images = Dynamic_image.images d in
  draw_dynamic_image_aux x_coord y_coord width images

let draw_dynamic_images dmap = SM.iter draw_dynamic_image dmap

let draw_subscreen _ p =
  let img = Subscreen.image p in
  let x = Subscreen.x_coord p in
  let y = Subscreen.y_coord p in
  let active = Subscreen.active p in
  if active then (
    let bmap = Subscreen.buttons p in
    let dmap = Subscreen.images p in
    draw_img img x y;
    draw_buttons bmap;
    draw_dynamic_images dmap)
  else ()

let draw_subscreens smap = SM.iter draw_subscreen smap

let initialize_window hs =
  open_graph "";
  resize_window (Home_screen.width hs) (Home_screen.height hs);
  set_window_title (Home_screen.window_title hs)

let draw_home_screen hs =
  let img = Home_screen.image hs in
  let x = Home_screen.x_coord hs in
  let y = Home_screen.y_coord hs in
  Graphics.auto_synchronize false;
  draw_img img x y;
  let bmap = Home_screen.button_map hs in
  let smap = Home_screen.subscreen_map hs in
  draw_buttons bmap;
  draw_subscreens smap;
  Graphics.auto_synchronize true

let draw_die die =
  let img = Die.image die in
  let x = Die.x_coord die in
  let y = Die.y_coord die in
  draw_img img x y

let draw_dice dice = map_draw draw_die dice

let draw_game_screen gs =
  Graphics.auto_synchronize false;
  let background_img = Game_screen.background_image gs in
  let bi_x = Game_screen.background_xcoord gs in
  let bi_y = Game_screen.background_ycoord gs in
  draw_img background_img bi_x bi_y;
  let gameboard_img = Game_screen.gameboard_image gs in
  let gb_x = Game_screen.gameboard_xcoord gs in
  let gb_y = Game_screen.gameboard_ycoord gs in
  draw_img gameboard_img gb_x gb_y;
  let dice = Game_screen.dice gs in
  draw_dice dice;
  let info_cards = Game_screen.info_cards gs in
  draw_subscreen () info_cards;
  let team_info = Game_screen.team_info gs in
  draw_subscreens team_info;
  let buttons = Game_screen.buttons gs in
  draw_buttons buttons;
  Graphics.auto_synchronize true

let rec press_button key =
  let status_key = (wait_next_event [ Key_pressed ]).key in
  if status_key = key then () else press_button key

let mouse_click () =
  let status_mouse = wait_next_event [ Button_down ] in
  (status_mouse.mouse_x, status_mouse.mouse_y)
