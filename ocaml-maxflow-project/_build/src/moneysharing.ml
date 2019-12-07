open Graph
open Gfile
open Tools
open Fordfulkerson

let rec print_money_sharing_list = function
  | [] -> "\n"
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

let rec print_diff_id_list = function
  | [] -> "\n"
  | [(name, payed, id)] -> "(" ^ name ^ ", " ^ (string_of_int payed) ^ ", " ^ (string_of_int id) ^ ")\n"
  | (name, payed, id) :: tail -> "(" ^ name ^ ", " ^ (string_of_int payed) ^ ", " ^ (string_of_int id) ^ ") -> " ^ (print_diff_id_list tail)

let rec calculate_sum = function
  | [] -> 0
  | (_, payed) :: tail -> payed + (calculate_sum tail)

let rec count_persons = function
  | [] -> 0
  | _ :: tail -> 1 + (count_persons tail)

let average_payment payed money_sharing_list =
  let nb_persons = count_persons money_sharing_list in
  payed / nb_persons

let calculate_diff money_sharing_list payment_division =
  let rec create_diff_list pd acu = function
    | [] -> acu
    | (name, payed) :: tail -> create_diff_list payment_division ((name, (payed - payment_division)) :: acu) tail
  in
  create_diff_list payment_division [] money_sharing_list

(* This function associates to every pair of a person and the  *)
(* money they paid a triple with their name, the money they    *)
(* paid and the id of the node associated to them in the graph *)
let create_diff_id_list diff_list =
  let rec aux id = function
    | [] -> []
    | (name, to_pay) :: tail -> (name, to_pay, id) :: (aux (id + 1) tail)
  in
  aux 1 diff_list

let create_initial_graph diff_id_list =

  let rec create_nodes_from_list g = function
    | [] -> g
    | (_,_,id) :: tail -> create_nodes_from_list (new_node g id) tail
  in
  let graph = create_nodes_from_list empty_graph diff_id_list in

  (* Add conversion arcs with and int_max/2 value (= infinity) *)
  let rec add_arcs_list_tail graph id1 = function
    | [] -> graph
    | (_,_,id2) :: tail -> add_arcs_list_tail (new_arc graph id1 id2 (max_int/2)) id1 tail
  in

  let rec add_conversion_arcs graph = function
    | [] -> graph
    | (_,_,id1) :: tail -> add_conversion_arcs (add_arcs_list_tail graph id1 tail) tail
  in
  let conversion_arcs_graph = add_conversion_arcs graph diff_id_list in

  let build_returning_arcs_graph graph =
    let new_graph = clone_nodes graph in
    let f g_ret id1 id2 lbl =
      let g_ret1 = add_arc g_ret id1 id2 lbl in
      add_arc g_ret1 id2 id1 (max_int/2)
    in
    e_fold graph f new_graph
  in
  let all_arcs_graph = build_returning_arcs_graph conversion_arcs_graph in

  (* Creates the first node. The 0 node is the source node.    *)
  (* It's the node for all the entering money. Every people    *)
  (* node who receives an arc coming from this starting node   *)
  (* owes money to someone.                                    *)
  let start_graph = new_node all_arcs_graph 0 in

  let nb_pers = count_persons diff_id_list in

  (* Creates the last node. This node is the sink node.        *)
  (* It's the node for all the exiting money. Every people     *)
  (* node who outputs an arc towards this sinking node         *)
  (* should receive money from someone.                        *)
  let final_graph = new_node start_graph (nb_pers + 1) in

  let rec diff_list_arcs graph nb_pers = function
    | [] -> graph
    | (_, money, id) :: tail -> 
      begin
        if money < 0 then diff_list_arcs (new_arc graph 0 id (abs money)) nb_pers tail
        else diff_list_arcs (new_arc graph id (nb_pers + 1) money) nb_pers tail
      end
  in

  diff_list_arcs final_graph nb_pers diff_id_list

let apply_ford_fulkerson graph src snk =
  let (res_graph, max_flow) = ford_fulkerson_algorithm graph src snk in
  res_graph

let associated_name_to_id id diff_id_list =
  let aux idb (name, money, ida) = (ida = idb) in
  let (name, money, id1) = List.find (aux id) diff_id_list in
  name

let show_final_user_payment graph nb_pers diff_id_list file = 
  let to_pay file id1 id2 money =
    if id1 = 0 || id1 = (nb_pers + 1) || id2 = 0 || id2 = (nb_pers + 1) then ()
    else
      begin
        if (money - (max_int/2)) < 0 then
          let name1 = associated_name_to_id id1 diff_id_list in
          let name2 = associated_name_to_id id2 diff_id_list in
          Printf.printf "%s has to pay %d€ to %s\n%!" name1 (abs (money - (max_int/2))) name2;
          Printf.fprintf file "%s has to pay %d€ to %s\n" name1 (abs (money - (max_int/2))) name2
        else ()
      end
  in
  let out_file = open_out file in
  Printf.printf "\n%!";
  e_iter graph (to_pay out_file);
  close_out out_file;
  ()

let unify_money_sharing_list money_sharing_list =
  let rec add_money add name = function
    | [] -> failwith "Name not found in list"
    | (name_b, money) :: tail -> 
      if (name_b = name)
      then (name, money + add) :: tail
      else (name_b, money) :: (add_money add name tail)
  in

  let rec loop ret_list names_list = function
    | [] -> ret_list
    | (name, money) :: tail ->
      if (List.mem name names_list) 
      then loop (add_money money name ret_list) names_list tail
      else loop ((name, money) :: ret_list) (name :: names_list) tail
  in

  loop [] [] money_sharing_list

let solve_money_sharing_problem money_sharing_list outfile =

  let unique_money_sharing_list = unify_money_sharing_list money_sharing_list in
  let nb_pers = count_persons unique_money_sharing_list in
  Printf.printf "%s%!" (print_money_sharing_list unique_money_sharing_list);

  let sum_payed = calculate_sum unique_money_sharing_list in
  Printf.printf "Sum of all payed : %d.\n%!" sum_payed;

  let payment_division = average_payment sum_payed unique_money_sharing_list in
  Printf.printf "Everyone should pay %d.\n%!" payment_division;

  let diff_list = calculate_diff unique_money_sharing_list payment_division in
  Printf.printf "%s%!" (print_diff_list diff_list);

  let diff_id_list = create_diff_id_list diff_list in
  Printf.printf "%s%!" (print_diff_id_list diff_id_list);

  let int_graph = create_initial_graph diff_id_list in

  let res_graph = apply_ford_fulkerson int_graph 0 (nb_pers + 1) in

  show_final_user_payment res_graph nb_pers diff_id_list outfile