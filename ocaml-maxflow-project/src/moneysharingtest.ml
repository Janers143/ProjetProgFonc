open Gfile
open Tools
open Fordfulkerson
open Moneysharing

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 3  then
    begin
      Printf.printf "\nUsage: %s infile outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;

  let infile = Sys.argv.(1) in
  let outfile = Sys.argv.(2) in

  let money_sharing_list = read_money_sharing_file infile in

  solve_money_sharing_problem money_sharing_list outfile;
  ()