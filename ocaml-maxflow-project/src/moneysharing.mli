open Graph
open Gfile

(* Function that transforms a money sharing list into a printable string                *)
val print_money_sharing_list: (string * int) list -> string

(* Function that transforms a payment difference list into a printable string           *)
val print_diff_list: (string * int) list -> string

(* Function that transforms a payment difference list with ids into a printable string  *)
val print_diff_id_list: (string * int * id) list -> string

(* Function that counts the number of persons that appear in any list (counts the nb    *)
(* of elements of the list)                                                             *)
val count_persons: 'a list -> int

(* Function that calculates the sum of all the money payed by the people in a money     *)
(* sharing list *)
val calculate_sum: (string * int) list -> int

(* Function that calculates the amount that everyone should pay                         *)
val average_payment: int -> (string * int) list -> int

(* Function that calculates for each person in a money sharing list the difference      *)
(* between what he should have payed and what he actually payed                         *)
val calculate_diff: (string * int) list -> int -> (string * int) list

(* Function that takes a payment difference list and affects to every person in it a    *)
(* unique id that will be used to identify the person in the graph                      *)
val create_diff_id_list: (string * int) list -> (string * int * id) list

(* Function that creates a new graph in which every person is represented by a node     *)
(* with a unique id. All the nodes that represent a person have outgoing arcs to every  *)
(* other person. These arcs have a value equal to (max_int / 2). There are two more     *)
(* nodes : a source node and a sink node. For every person, if he has payed more than   *)
(* he should have, he's attached to the sink node. In the other case, he's attached to  *)
(* the source node.                                                                     *)
val create_initial_graph: (string * int * id) list -> int graph

(* Function that applies the Ford Fulkerson algorithm (defined in the Fordfulkerson     *)
(* module) to the graph created by the function above                                   *)
val apply_ford_fulkerson: int graph -> id -> id -> int graph

(* Function that prints to the terminal and in the specified file (given in the argv    *)
(* parameters) what everyone should pay and to who it should pay it *)
val show_final_user_payment: int graph -> int -> (string * int * id) list -> path -> unit

(* Function that takes a money sharing list where a single person can appear many times *)
(* paying different amounts and returns a list with every person appearing a single     *)
(* time with the sum of all he has payed.                                               *)
val unify_money_sharing_list: (string * int) list -> (string * int) list

(* Function that solves the money sharing problem (by using all the functions described *)
(* above). It takes a money sharing list (read in a file with the                       *)
(* read_money_sharing_file defined in the Gfile module) and a path to the file in which *)
(* we want to write the solution. *)
val solve_money_sharing_problem: (string * int) list -> path -> unit