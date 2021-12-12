module Make (Ord : Map.OrderedType) = struct
  module M = Map.Make (Ord)
  include M

  let rec of_lst lst map =
    match lst with
    | [] -> map
    | (k, v) :: t ->
        M.union
          (fun _ _ _ -> failwith "precondition violation")
          (M.add k v map) (of_lst t map)

  let filter_key key map = M.filter (fun k _ -> k <> key) map

  let combine map1 map2 =
    M.union (fun _ _ _ -> failwith "precondition violation") map1 map2
end

module SM = Make (String)
module IM = Make (Int)
