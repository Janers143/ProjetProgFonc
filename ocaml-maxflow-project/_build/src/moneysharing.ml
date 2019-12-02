open Graph
open Tools

let rec print_money_sharing_list = function
  | [] -> ""
  | [(name, payed)] -> name ^ " payed " ^ (string_of_int payed) ^ "\n"
  | (name, payed) :: tail -> name ^ " payed " ^ (string_of_int payed) ^ " -> " ^ (print_money_sharing_list tail)

let rec print_diff_list = function
  | [] -> "\n"
  | [(name, payed)] -> name ^ 
                       if payed < 0 then 
                         " should pay " ^ (string_of_int (abs payed)) ^ "\n"
                       else
                         " should receive " ^ (string_of_int payed) ^ "\n"
  | (name, payed) :: tail -> name ^ 
                             if payed < 0 then 
                               " should pay " ^ (string_of_int (abs payed)) ^ " -> " ^ (print_diff_list tail)
                             else
                               " should receive " ^ (string_of_int payed) ^ " -> " ^ (print_diff_list tail)                                  

let rec calculate_sum = function
  | [] -> 0
  | (_, payed) :: tail -> payed + (calculate_sum tail)

let payed_per_person payed money_sharing_list =
  let rec count_persons = function
    | [] -> 0
    | _ :: tail -> 1 + (count_persons tail)
  in
  let nb_persons = count_persons money_sharing_list in
  payed / nb_persons

let calculate_diff money_sharing_list payment_division =
  let rec create_diff_list pd acu = function
    | [] -> acu
    | (name, payed) :: tail -> create_diff_list payment_division ((name, (payed - payment_division)) :: acu) tail
  in
  create_diff_list payment_division [] money_sharing_list