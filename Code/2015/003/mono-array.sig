(* mono-array.sig
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

signature MONO_ARRAY_EXT =
  sig

    include MONO_ARRAY

    val toList : array -> elem list

    val fromVector : vector -> array
    val toVector   : array -> vector

  end
