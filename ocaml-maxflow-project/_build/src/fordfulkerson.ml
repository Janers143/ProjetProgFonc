open Graph
open Tools

type path = id list

let find_path (graph : int graph) (start : id) (term : id) (visited : (id * id) list) =
  let new_visited = (start, (-1)) :: visited in

  let nodes_vis = [] in
  let rec loop g s t vis n_vis =
    let rec parcours_out_arcs = function
      | [] -> None
      | (id, lbl) :: tail -> 
        if ((List.mem s n_vis) || (lbl = 0))
        then parcours_out_arcs tail
        else let new_n_vis = s::n_vis in
          begin 
            match loop g id t ((id, s) :: vis) new_n_vis with 
            | None -> parcours_out_arcs tail
            | Some x -> Some (s::x)
          end
    in

    if s = t then Some [s]
    else parcours_out_arcs (out_arcs g s)
  in

  let new_visited = loop graph start term new_visited nodes_vis in

  new_visited
;;

let find_min_flow_path graph path =
  let rec loop g min = function
    | [] -> min
    | [x] -> min
    | x :: y :: tail -> 
      begin match (find_arc g x y) with
        | None -> failwith "Error : There's no arc going from x to y (find_min_flow_path)"
        | Some a -> if (a < min) then loop g a (y::tail) else loop g min (y::tail)
      end
  in
  loop graph 999999 path
;;

let build_res_graph graph =

  let new_graph = clone_nodes graph in
  let f g_ret id1 id2 lbl =
    let g_ret1 = add_arc g_ret id1 id2 lbl in
    add_arc g_ret1 id2 id1 0
  in
  e_fold graph f new_graph
;;

let augment_flow graph path = 

  let min_flow = find_min_flow_path graph path in
  let get_opt_lbl graph id1 id2 =
    match (find_arc graph id1 id2) with
    | None -> failwith "Error : No such arc (augment_flow)"
    | Some x -> x
  in
  let rec loop g = function
    | [] -> g
    | [x] -> g
    | x :: y :: tail ->
      let new_graph1 = add_arc g y x min_flow in 
      let new_graph2 = new_arc new_graph1 x y ((get_opt_lbl new_graph1 x y) - min_flow) in
      loop new_graph2 (y::tail)
  in
  loop graph path
;;
