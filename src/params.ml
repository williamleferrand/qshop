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

let collection_id = "188315" 
let section_id = "399833"
let storeid =  "148434" 
let exception_url = "http://www.google.fr"

(* Printfection credentials *)

let api_key = fetch "printfection-api-key" (* "adb0dc152f87054c18dfa4d97592e72f" *) 
let secret_key = fetch "printfection-secret-key" (* "e8a2fe3d93181daea179b9618b937a5d" *)
let session_key = fetch "printfection-session-key" (* ceda2ae3247ca2fd-117763 *) 

let title = "no-title"
