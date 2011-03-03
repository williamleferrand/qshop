(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)


open Lwt 
open Misc

exception Error 

let transparent local_path new_local_path  = 
  let full_path = Params.public ^ local_path in
  let new_full_path = Params.public ^ new_local_path in 
  
  let args = [| Params.convert; "-transparent" ; "white"; full_path; new_full_path |] in 
    
  Lwt_process.exec (Params.convert, args) >>= fun status -> 
    match status with
      | Unix.WEXITED 0 -> return new_local_path
      | _ -> raise Error

let resize size local_path new_local_path = 
  let full_path = Params.public ^ local_path in 
  let new_full_path = Params.public ^ new_local_path in 
  
  let args = [| Params.convert; "-resize" ; size; full_path; new_full_path |] in 
  
  Lwt_process.exec (Params.convert, args) >>= fun status -> 
    match status with
      | Unix.WEXITED 0 -> return new_local_path
      | _ -> raise Error
  

  
let composite geometry skeleton local_path new_local_path =

  let full_path = Params.public ^ local_path in 
  let new_full_path = Params.public ^ new_local_path in 

  let args = [| Params.composite; 
		"-geometry" ; geometry; 
		full_path; skeleton; new_full_path |] in 
  
  Lwt_process.exec (Params.composite, args) >>= fun status -> 
    match status with
      | Unix.WEXITED 0 -> return new_local_path
      | _ -> raise Error
