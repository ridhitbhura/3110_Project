type t

let roll_dice _ =
  Random.self_init ();
  Random.int 7 + Random.int 7
let rec handle2 _ =
  let x = roll_dice 0 in
  if x < 2 then roll_dice 0 else handle2 0