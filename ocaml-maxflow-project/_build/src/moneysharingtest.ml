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
  ()