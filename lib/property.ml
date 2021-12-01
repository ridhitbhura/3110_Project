open Yojson.Basic.Util

type control =
  | Base
  | Set
  | ControlOne
  | ControlTwo
  | ControlThree
  | ControlFour
  | TakeOver

type rent = {
  base : int;
  set : int;
  control_one : int;
  control_two : int;
  control_three : int;
  control_four : int;
  take_over : int;
}

type cost = {
  initial_purchase : int;
  build_control : int;
  remove_control : int;
  withdraw : int;
}

type status =
  | Owned
  | Unowned

type t = {
  rent : rent;
  control : control;
  cost : cost;
  status : status;
  image_name : string;
}

let image_name p = p.image_name

let get_control p = p.control

let acquire p = { p with status = Owned }

let is_acquirable p =
  match p.status with
  | Owned -> false
  | Unowned -> true

let complete_set p =
  {
    p with
    control =
      (match p.control with
      | Base -> Set
      | _ -> failwith "Only a Base property can be made into a Set.");
  }

let remove_set p =
  {
    p with
    control =
      (match p.control with
      | Set -> Base
      | _ -> failwith "Only a Set property can turned back into a Base.");
  }

let upgrade p =
  {
    p with
    control =
      (match p.control with
      | Base -> failwith "Base property is not upgradable."
      | Set -> ControlOne
      | ControlOne -> ControlTwo
      | ControlTwo -> ControlThree
      | ControlThree -> ControlFour
      | ControlFour -> TakeOver
      | TakeOver -> failwith "Takeover property is not upgradable.");
  }

let upgrade_cost p = p.cost.build_control

let is_upgradable p =
  match p.control with
  | Base
  | TakeOver ->
      false
  | _ -> true

let degrade p =
  {
    p with
    control =
      (match p.control with
      | Base -> failwith "Base property is not degradable."
      | Set -> failwith "Set property is not degradable"
      | ControlOne -> Set
      | ControlTwo -> ControlOne
      | ControlThree -> ControlTwo
      | ControlFour -> ControlThree
      | TakeOver -> ControlFour);
  }

let degrade_refund p = p.cost.remove_control

let is_degradable p =
  match p.control with
  | Set
  | Base ->
      false
  | _ -> true

let get_rent p =
  match p.control with
  | Base -> p.rent.base
  | Set -> p.rent.set
  | ControlOne -> p.rent.control_one
  | ControlTwo -> p.rent.control_two
  | ControlThree -> p.rent.control_three
  | ControlFour -> p.rent.control_four
  | TakeOver -> p.rent.take_over

let withdraw p = { p with status = Unowned }

let withdraw_refund p = p.cost.withdraw

type init = {
  base_rent : int;
  set_rent : int;
  control_one_rent : int;
  control_two_rent : int;
  control_three_rent : int;
  control_four_rent : int;
  take_over_rent : int;
  initial_purchase_cost : int;
  build_control_cost : int;
  remove_control_refund : int;
  withdraw_cost : int;
  image_name : string;
}

let make i =
  let rnt =
    {
      base = i.base_rent;
      set = i.set_rent;
      control_one = i.control_one_rent;
      control_two = i.control_two_rent;
      control_three = i.control_three_rent;
      control_four = i.control_four_rent;
      take_over = i.take_over_rent;
    }
  in
  let cst =
    {
      initial_purchase = i.initial_purchase_cost;
      build_control = i.build_control_cost;
      remove_control = i.remove_control_refund;
      withdraw = i.withdraw_cost;
    }
  in
  let s = Unowned in
  let ctrl = Base in
  {
    rent = rnt;
    cost = cst;
    status = s;
    control = ctrl;
    image_name = i.image_name;
  }

let get_property_from_json json =
  let base = json |> member "fee" |> member "base" |> to_int in
  let set = json |> member "fee" |> member "set" |> to_int in
  let control_one =
    json |> member "fee" |> member "control_1" |> to_int
  in
  let control_two =
    json |> member "fee" |> member "control_2" |> to_int
  in
  let control_three =
    json |> member "fee" |> member "control_3" |> to_int
  in
  let control_four =
    json |> member "fee" |> member "control_4" |> to_int
  in
  let take_over =
    json |> member "fee" |> member "take_over" |> to_int
  in
  let inital = json |> member "purchase_cost" |> to_int in
  let upgrade = json |> member "upgrade_cost" |> to_int in
  let degrade = json |> member "degrade_refund" |> to_int in
  let withdraw = json |> member "mortgage" |> to_int in
  let img = json |> member "image_name" |> to_string in
  let init =
    {
      base_rent = base;
      set_rent = set;
      control_one_rent = control_one;
      control_two_rent = control_two;
      control_three_rent = control_three;
      control_four_rent = control_four;
      take_over_rent = take_over;
      initial_purchase_cost = inital;
      build_control_cost = upgrade;
      remove_control_refund = degrade;
      withdraw_cost = withdraw;
      image_name = img;
    }
  in

  make init

(** [get_properties_from_json json] parses all the properties from the
    json*)
let get_properties_from_json json =
  json |> member "properties" |> to_list
  |> List.map get_property_from_json
