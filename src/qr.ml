(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)


open Lwt 
open Misc

exception Error 

let generate ?(size=9) local_path target = 

  let full_path = Params.public ^ local_path in
  (*
  catch 
    (fun () -> Unix.access full_path [ Unix.F_OK ]; return local_path)  
    (fun _ -> *) 
      let args = [| Params.qrencode; "-m"; "0"; "-o" ; full_path; "-s"; string_of_int size; "-l"; "M"; target |] in 
      
      Lwt_process.exec (Params.qrencode, args) >>= fun status -> 
      match status with
	| Unix.WEXITED 0 -> return local_path
	| _ -> raise Error (* ) *)
	  
