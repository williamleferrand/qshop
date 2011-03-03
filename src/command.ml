(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)

open Lwt
open Json_type
open Misc

(* Helpers *************************************************************************)

let generate target = 
  let small = Files.fresh () in
  let small_transp = Files.fresh () in 
  lwt qr1 = Qr.generate small target in
  Convert.transparent qr1 small_transp 

let assemble target model = 
  let big = Files.fresh () in 
  let big_transp = Files.fresh () in 
  lwt qr1 = Qr.generate ~size:17 big target in
  lwt qr2 = Convert.transparent qr1 big_transp in
  let resize = Params.get_resize model in 
  let pos = Params.get_pos model in
  let layout = Params.get_layout model in 
  let big_transp_sized = Files.fresh () in 
  let big_transp_sized_final = Files.fresh () in  
  lwt qr3 = Convert.resize resize qr2 big_transp_sized in 
  lwt qr4 = Convert.composite pos layout qr3 big_transp_sized_final in 
  return qr4
  
(* GENERATION ENDPOINTS ************************************************************)

let preview_indirect_handler sp target _ = 
  lwt qr = generate target in 
  return (Json.result (Params.prefix ^ qr))

let preview_direct_handler sp target _ = 
  lwt qr = generate target in 
  return (Params.public ^ qr)

let generate_handler sp (target, (model, (genre, (color, size)))) _ =
  lwt image = assemble target model in
  return Json.ok

(* POLLER **************************************************************************)

let status_handler sp _ _ = 
  return Json.ok

(* Handlers registration ***********************************************************)

let _ = 
  register Services.preview_indirect preview_indirect_handler ; 
  Eliom_predefmod.Files.register Services.preview_direct preview_direct_handler ;
  register Services.generate generate_handler ; 
  register Services.status status_handler
