
type property_name = string 

type weapon_name = string 

type food_name = string 

type corner_name = string 

type cost = int 

type location = int 

type board_order = int

exception UnknownProperty of property_name

exception UnknownCorner of corner_name 

type set = {
  set_name: string;
  property_set : property_name list  
}

type property = {
  property_name: property_name; 
  set_name: set;
  upgrade_cost: int ; 
  purchase_cost: int; 
  tax: int; 
  board_order: board_order;
  (* owner: Player.get_name input; *)
  (* image: Image *)
}


type weapon = { 
  name: weapon_name;
  damage: int; 
  descrption: string; 
  (* image: Image *)
}

type weapon_stack = { 
  weapons_left: weapon list;
  board_order : board_order;
  
}
type food = { 
  hp_gain : int ;
  description : string; 
  (* image: Image *)
}

type food_stack = { 
  food_left : food list;
  board_order : board_order

}

type corner = {
  corner_name : string; 
  board_order :  board_order;
}

type t = {
  properties : property list; 
  weapon_stack: weapon_stack;
  food_stack : food_stack;
  corners: corner list; 
}

