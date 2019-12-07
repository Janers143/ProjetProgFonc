open Graph
open Gfile

(* Function that transforms a money sharing list into a printable string *)
val print_money_sharing_list: (string * int) list -> string

(* Function that transforms a payment difference list into a printable string *)
val print_diff_list: (string * int) list -> string

val print_diff_id_list: (string * int * id) list -> string

val count_persons: 'a list -> int

(* Function that  *)
val calculate_sum: (string * int) list -> int

(*  *)
val average_payment: int -> (string * int) list -> int

(*  *)
val calculate_diff: (string * int) list -> int -> (string * int) list

val create_diff_id_list: (string * int) list -> (string * int * id) list

val create_initial_graph: (string * int * id) list -> int graph

val apply_ford_fulkerson: int graph -> id -> id -> int graph

val show_final_user_payment: int graph -> int -> (string * int * id) list -> path -> unit

val unify_money_sharing_list: (string * int) list -> (string * int) list

val solve_money_sharing_problem: (string * int) list -> path -> unit