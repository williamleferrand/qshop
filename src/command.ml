(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)

open Lwt
open Json_type
open Misc

(* GENERATION ENDPOINTS ************************************************************)

let preview_handler sp _ _ = 
  return Json.ok 

let generate_handler sp _ _ =
  return Json.ok

(* POLLER **************************************************************************)

let status_handler sp _ _ = 
  return Json.ok

(* Handlers registration ***********************************************************)

let _ = 
  register Services.preview preview_handler ; 
  register Services.generate generate_handler ; 
  register Services.status status_handler
