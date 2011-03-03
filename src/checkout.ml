(*
 * qshop 0.1
 *
 * (c) 2011 William Le Ferrand 
 *)

open Printf
open Printfection

open Misc
open Params

let printfection = Printfection.Connection.create Params.api_key Params.secret_key Params.session_key 

let exec size (rootid, rootcolorids) image =
  debug "@@@ Entering the checkout process\n";
  try 
  (* Upload the image *)
    let imageid = Command.Upload.exec printfection (Filename.basename image) Params.collection_id (Params.public ^ image) in 
    debug "@@@ Imageid: %s\n" imageid ; 
    
  (* Create the product *)
    let sectionid = Params.section_id in (* Generated section on our store *)
    let rootcolorids = (string_of_int rootcolorids) in
    let specs = sprintf "[{\"side\": 0, \"imageid\": %s, \"height\": 18, \"position\": 1, \"center_percent_x\": 0.0 }]" imageid in 
    
    let productid = Command.Product_create.exec printfection rootid sectionid rootcolorids specs in 
    debug "@@@ Productid: %s\n" productid; 

(* Set the commission *)
    let commission = (List.fold_left (fun acc (r, p) -> Printf.sprintf "%s%s{ \"range\": %d, \"price\": %d } " acc (if acc = "[" then "" else ",") r p) "[" [ (1, 5); (2, 5); (3, 5); (4, 5); (5, 5); (6, 5); (7, 5) ])  ^ "]" in
    let title = Params.title in
    let productset =  Command.Product_set.raw_exec printfection productid title commission in
      debug "@@@ Productset: %s\n" productset; 

(* Open the cart *)
    let cart_key = Command.Cart_create.exec printfection  in
    debug "@@@ Cart_key: %s\n" cart_key;
    
      (* Add the product to the cart *)
    debug "@@@ Size: %d\n" size ;
    let invoice = Command.Cart_addProduct.raw_exec printfection cart_key productid rootcolorids (string_of_int size) "1" in
    debug "@@@ Invoice: %s\n" invoice ;
    
	   (* Get the co url *)
    let co_url = Command.Checkout.raw_exec printfection cart_key storeid "cart" in
    debug "@@@ Browse this co URL to co url: %s\n" co_url ; 
    co_url
      
  with e -> 
    debug "@@@ Exception caught in checkout: %s\n" (Printexc.to_string e); 
    Params.exception_url 
    
    
