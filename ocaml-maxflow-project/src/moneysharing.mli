open Graph

(* Function that transforms a money sharing list into a printable string *)
val print_money_sharing_list: (string * int) list -> string

(* Function that transforms a payment difference list into a printable string *)
val print_diff_list: (string * int) list -> string

(* Function that  *)
val calculate_sum: (string * int) list -> int

(*  *)
val payed_per_person: int -> (string * int) list -> int

(*  *)
val calculate_diff: (string * int) list -> int -> (string * int) list