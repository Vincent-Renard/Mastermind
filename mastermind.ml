type couleur= Rouge | Bleu | Vert | Blanc | Jaune | Noir | Violet | Orange;;
(**)
let taille=5;;
(**)
let liste_couleurs =  [ "rouge";"vert";"blanc";"noir";"bleu";"jaune";"violet";"orange"] ;;


let rec  construire taille =
  let rec construire_aux liste =
    match liste with
    |[]->[]
    |h::t -> (("rouge"::h)::(("vert"::h)::(("blanc"::h)::(("noir"::h)::(("bleu"::h)::(("jaune"::h)::(("violet"::h)::(("orange"::h)::(construire_aux t)))))))))
  in match taille with
  |1 ->[["rouge"];["vert"];["blanc"];["noir"];["bleu"];["jaune"];["violet"];["orange"]]
  |_->construire_aux (construire(taille-1));;
(**)

let  occur liste couleur=
  let rec aux liste couleur n =
    match liste with 
    |[] -> n
    |h::t -> if h=couleur then aux t couleur (n+1) else aux t couleur n 
  in aux liste couleur 0;;
(**)

 let rec  suppr_utile l =
     match l with 
     |[] -> false
     |h::t -> if ( est_dans h t) then true else suppr_utile t ;;
let est_dans  couleur liste =
  ((occur liste couleur) >0) ;;
(* tests *)
let ltruc = [1;8;5;3;8;25;8;5;3;8;1;2;8];;
let ltrucbis = [1;2;3;4;5;6;7;8;9];;
let test1=suppr_utile ltruc;;
let test2=suppr_utile ltrucbis;;


let string_liste liste=
  let rec aux l couleur s=
    match l  with
    |[]->s;
    |[h::t]->begin match h with
		   |Rouge->s^"rouge;"
		   |Vert->s^"vert;"
		   |Bleu->s^"bleu;"
		   |Noir->s^"noir;"
		   |Violet->s^"violet;"
		   |Jaune->s^"jaune;"
		   |Orange->s^"orange;"
		   |Blanc->s^"blanc;"
  in aux liste (List.hd liste)"";;

let elaguer_liste_comb liste_comb  = 
  let rec elaguer_liste_comb_aux liste_comb res =
    match liste_comb with
    |[] -> res
    |h::t -> if (suppr_utile h)then elaguer_liste_comb_aux t res else elaguer_liste_comb_aux t res@h
  in elaguer_liste_comb_aux liste_comb [] ;;
     

let jouer liste = 
  let rec aux liste =
    match liste with
    |[]->print_string "Tricheur,vous avez menti!"
    |[good_combi]->print_string "La bonne réponse est :\n";
		   string_liste good_combi;
    |h::t->proposer_combi h;
	   print_string "\n";
	   aux (delete_combi h)
  in aux liste;;

     let game1 x =
       let rec aux x=
	 match x with
	 |0->failwith "End Game"
	 |1->jouer(elaguer_liste_comb (construire 5))
	 |2->main()
	 |_->failwith "Erreur"
       in aux x;;

let game2 x =
  let rec aux x=
    match x with
    |0->failwith "End Game"
    |1->jouer(construire 5)
    |2->main()
    |_->failwith "Erreur" (* pas explicite ! *)
  in aux x;;

let game3 x =
  let rec aux x=
    match x with
    |0->failwith "End Game" (* on termine le jeu *)
    |1->jouer(construire 5)
    |2->main()
    |_->failwith "Erreur"
  in aux x;;

let partie x =   
    match x with
    |1->game1 x 
    |2->game2 x
    |3->game3 x
    |_->failwith "Erreur";;

let main()=print_string "Bienvenue dans le Mastermind \n";
	   print_string "Quel mode de jeu voulez vous jouez?\n";
	   print_string "1.Sans plusieurs occurence de couleurs\n";
	   print_string "2.Avec plusieurs occurence de couleurs\n";
	   print_string "3.Avec plusieurs occurence de couleur et limité à 20 essais\n";
	   let s=read_line() in
	   partie s;;

main();;

