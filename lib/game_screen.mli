(** List of popups; list of buttons; list of players; list of property
    cards. Use command.mli to check for user input; and update state;
    current player turn, etc*)

type t

val get_game_screen_from_json : Yojson.Basic.t -> t