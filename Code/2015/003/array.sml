(* array.sml
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

structure ArrayExt : ARRAY_EXT =
  struct

    open Array

    fun toList arr = List.tabulate(length arr, fn i => sub(arr, i))

    fun fromVector vec = tabulate (Vector.length vec, fn i => Vector.sub(vec, i))

    val toVector = vector

  end
