open Graphics

let () = open_graph ""

let () = set_window_title "Hello"

let () = draw_string "Hello"

let () = print_endline "Hello, World!"

let x = wait_next_event [Key_pressed]