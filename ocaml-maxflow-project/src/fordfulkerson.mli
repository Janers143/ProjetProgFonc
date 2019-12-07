open Graph

(* We define a path as list of succesives ids to follow.                            *)
type path = id list

(* Returns a path going from node s to node t.                                      *)
val find_path: int graph -> id -> id -> (id * id) list -> path option

(* Returns the minimal flow value of a given path.                                  *)
val find_min_flow_path: int graph -> path -> int

(* Buils a new residual graph from a normal graph.                                  *)
val build_res_graph: int graph -> int graph

(* Augments the flow in the residual graph following a given path.                  *)
val augment_flow: int graph -> path -> int graph

(* Executes the complete Ford-Fulkerson algorithm.                                  *)
(* Returns a tuple that contains a final residual graph and the maximum flow value. *)
val ford_fulkerson_algorithm: int graph -> id -> id -> (int graph * int)