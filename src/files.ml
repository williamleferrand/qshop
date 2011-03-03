(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)

let cnt = ref 0 

let fresh () = 
  incr cnt ; 
  Printf.sprintf "/__generated__%d.png" !cnt 

(* todo : add Lwt_timeout to unlink the file *)
