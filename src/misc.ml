(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)



open Lwt 

let warning fmt = 
  Printf.ksprintf (fun s -> Ocsigen_messages.warning s) fmt ;;

let error fmt = 
  Printf.ksprintf (fun s -> Ocsigen_messages.errlog s) fmt ;;

let debug fmt = 
  Printf.ksprintf (fun s -> print_endline s) fmt ;;

let register service handler = 
  let json_handler sp gp pp =
    catch 
      (fun () -> 
	handler sp gp pp >>= fun json -> Eliom_predefmod.HtmlText.send ~sp (Json_io.string_of_json ~compact:false json))
      (fun e -> let json = Json.generic_error e in  Eliom_predefmod.HtmlText.send ~sp (Json_io.string_of_json ~compact:false json)) in 
 Eliom_predefmod.Any.register service json_handler
