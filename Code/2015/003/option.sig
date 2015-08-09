(* option.sig
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

signature OPTION_EXT =
  sig

    include OPTION

    val isNone : 'a option -> bool
    val fold : ('a * 'b -> 'b) -> 'b -> 'a option -> 'b

  end
