open Graph

type path = id list

(* Returns a path going from node s to node t *)
val find_path: int graph -> id -> id -> (id * id) list -> path option

val find_min_flow_path: int graph -> path -> int

val build_res_graph: int graph -> int graph

val augment_flow: int graph -> path -> int graph