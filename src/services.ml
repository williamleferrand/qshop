(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)

open Eliom_services
open Eliom_parameters

(* GENERATION ENDPOINTS ************************************************************)

let preview_indirect = new_service [ "preview"; "indirect" ] (string "target") ()
let preview_direct = new_service [ "preview"; "direct" ] (string "target") ()

let generate = new_service [ "generate" ] (string "target" ** (string "model" ** (string "genre" ** (string "color" ** string "size")))) () 

(* POLLER **************************************************************************)

let status = new_service [ "status" ] (string "token") () 
