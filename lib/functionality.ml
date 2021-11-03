open Graphics

let roll_dice _ =
  Random.self_init ();
  Random.int 7 + Random.int 7

let rec handle2 _ =
  let x = roll_dice 0 in
  if x < 2 then roll_dice 0 else handle2 0

let dimension_check mouse img_dim img_pos =
  if
    fst mouse > fst img_pos - (fst img_dim / 2)
    && fst mouse < fst img_pos + (fst img_dim / 2)
    && snd mouse > snd img_pos - (snd img_dim / 2)
    && snd mouse > snd img_pos - (snd img_dim / 2)
  then true
  else false

let rec is_dice_clicked img_dim img_pos =
  if button_down () then
    if dimension_check (mouse_pos ()) img_dim img_pos then handle2 0
    else is_dice_clicked img_dim img_pos
  else is_dice_clicked img_dim img_pos
