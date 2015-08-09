(* list-pair.sig
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

signature LIST_PAIR_EXT =
  sig

    include LIST_PAIR

    val appi		: (int * 'a * 'b -> unit) -> 'a list * 'b list -> unit
    val appiEq		: (int * 'a * 'b -> unit) -> 'a list * 'b list -> unit
    val mapi		: (int * 'a * 'b -> 'c) -> 'a list * 'b list -> 'c list
    val mapiEq		: (int * 'a * 'b -> 'c) -> 'a list * 'b list -> 'c list
    val mapPartial	: ('a * 'b -> 'c option) -> 'a list * 'b list -> 'c list
    val mapPartialEq	: ('a * 'b -> 'c option) -> 'a list * 'b list -> 'c list
    val mapPartiali	: (int * 'a * 'b -> 'c option) -> 'a list * 'b list -> 'c list
    val mapPartialiEq	: (int * 'a * 'b -> 'c option) -> 'a list * 'b list -> 'c list
    val foldli		: (int * 'a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c
    val foldliEq	: (int * 'a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c
    val foldri		: (int * 'a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c
    val foldriEq	: (int * 'a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c

  end
