(* string.sig
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

signature STRING_EXT =
  sig

    include STRING

    val rev : string -> string

    val implodeRev : char list -> string

    val concatWithMap : string -> ('a -> string) -> 'a list -> string

  end
