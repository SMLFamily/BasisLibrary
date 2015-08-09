(* array.sig
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

signature ARRAY_EXT =
  sig

    include ARRAY

    val toList : 'a array -> 'a list

    val fromVector : 'a vector -> 'a array
    val toVector   : 'a array -> 'a vector

  end
