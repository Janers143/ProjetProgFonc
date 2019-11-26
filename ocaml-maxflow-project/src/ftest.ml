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

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)

  (* Test for add_arc *)
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in
  let res_graph = build_res_graph int_graph in
  let path_opt = find_path res_graph _source _sink [] in
  let get_opt = function
    | None -> []
    | Some x -> x
  in
  let path = get_opt path_opt in
  let augment_graph = augment_flow res_graph path in
  let min_flow = find_min_flow_path res_graph path in
  let rec string_of_list = function
    | None -> "Doesn't exist"
    | Some list -> 
      begin match list with
        | [] -> ""
        | (x :: y :: tail) -> (string_of_int x) ^ " -> " ^ (string_of_list (Some (y :: tail)))
        | [x]-> string_of_int x
      end
  in
  Printf.printf "%s\n%!" (string_of_list path_opt);
  Printf.printf "The min flow is : %d\n%!" min_flow;


  let augment_graph_string = gmap augment_graph string_of_int in


  (* Rewrite the graph that has been read. *)
  let () = export outfile augment_graph_string in

  ()
