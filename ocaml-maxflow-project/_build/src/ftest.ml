open Gfile
open Tools
open Fordfulkerson

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;

  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in

  (* Execute the Ford-Fulkerson algorithm on the given graph *)
  let (final_graph, max_flow) = ford_fulkerson_algorithm int_graph _source _sink in
  Printf.printf "Max flow : %s\n%!" (string_of_int max_flow);

  (* Write the final residual graph in dot format *)
  let final_graph_string = gmap final_graph string_of_int in
  let () = export outfile final_graph_string in

  ()
