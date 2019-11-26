open Graph

(* let gmap gr f =
   let f_unit node_id =
    let outa = out_arcs gr id
   in
   n_iter gr f_unit *)

let clone_nodes (gr : 'a graph) = n_fold gr new_node empty_graph;;

(*Hay que hacer los tests*)
let gmap gr f =
  let new_gr = clone_nodes gr in
  let create_new_arc n_gr id1 id2 old_lbl = new_arc n_gr id1 id2 (f old_lbl) in
  e_fold gr create_new_arc new_gr
;;

let add_arc gr id1 id2 n =
  match find_arc gr id1 id2 with
  | None -> new_arc gr id1 id2 n
  | Some x -> new_arc gr id1 id2 (n + x)
;;