(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)

open Eliom_services
open Eliom_parameters

(* GENERATION ENDPOINTS ************************************************************)

let preview = new_service [ "preview" ] (string "target") ()
let generate = new_service [ "generate" ] (string "kind" ** (string "genre" ** (string "color" ** string "size"))) () 

(* POLLER **************************************************************************)

let status = new_service [ "status" ] (string "token") () 
