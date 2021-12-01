type t = {
  buttons : Button.t list;
  players : Player.t list;
  properties : Property.t list;
  pop_ups : Popup.t list;
}

let _from_json (json : Yojson.Basic.t) : t =
  {
    buttons = Button.get_buttons_from_json json "game_screen";
    players = Player.get_players_from_json json;
    properties = Property.get_properties_from_json json;
    pop_ups = Popup.get_pop_ups_from_json json "game_screen";
  }
