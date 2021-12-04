open Graphics

let rec press_button key =
  let status_key = (wait_next_event [ Key_pressed ]).key in
  if status_key = key then () else press_button key