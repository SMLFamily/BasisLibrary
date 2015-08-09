(* mono-vector.sig
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

signature MONO_VECTOR_EXT =
  sig

    include MONO_VECTOR

    val toList : vector -> elem list

    val append  : vector * elem -> vector
    val prepend : elem * vector -> vector

  end
