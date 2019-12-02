open Gfile
open Tools
open Fordfulkerson
open Moneysharing

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 2 then
    begin
      Printf.printf "\nUsage: %s infile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;

  let infile = Sys.argv.(1) in

  let money_sharing_list = read_money_sharing_file infile in
  Printf.printf "%s%!" (print_money_sharing_list money_sharing_list);

  let sum_payed = calculate_sum money_sharing_list in
  Printf.printf "Sum of all payed : %d.\n%!" sum_payed;

  let payment_division = payed_per_person sum_payed money_sharing_list in
  Printf.printf "Everyone should pay %d.\n%!" payment_division;

  let diff_list = calculate_diff money_sharing_list payment_division in
  Printf.printf "%s%!" (print_diff_list diff_list);
  ()