(* vector.sig
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

signature VECTOR_EXT =
  sig

    include VECTOR

    val toList : 'a vector -> 'a list

    val append  : 'a vector * 'a -> 'a vector
    val prepend : 'a * 'a vector -> 'a vector

  end
