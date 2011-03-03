(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)

open Simplexmlparser

let config = 
  List.fold_left (fun acc e -> 
		    match e with
			Element(k, _ , PCData (v) :: _) ->
			  (k,v) :: acc
		      | _ -> acc)
    [] (Eliom_sessions.get_config ())
    

let fetch e = 
  try List.assoc e config with _ -> Printf.printf "Parameter %s is missing\n" e; flush stdout ; exit (-1)

let public = fetch "public" 
let prefix = fetch "prefix" 

let qrencode = fetch "qrencode" 
let convert = fetch "convert"
let composite = fetch "composite"

(* More complicated stuff *)
let get_resize model = ""
let get_pos model = ""
let get_layout model = ""
