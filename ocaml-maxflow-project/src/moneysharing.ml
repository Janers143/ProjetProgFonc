open Graph
open Tools

(* Function that prints a money sharing list *)
let rec print_money_sharing_list = function
  | [] -> ""
  | [(name,payed)] -> name ^ " payed : " ^ (string_of_int payed) ^ "\n"
  | (name, payed) :: tail -> name ^ " payed : " ^ (string_of_int payed) ^ " -> " ^ (print_money_sharing_list tail)