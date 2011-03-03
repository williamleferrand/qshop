(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)

open Json_type 

let ok = Object [ "status", Int 0; "msg", String "ok" ]
let generic_error e = Object [ "status", Int 2; "msg", String (Printexc.to_string e)]

let result path = Object [ "status", Int 0; "src", String path ]
