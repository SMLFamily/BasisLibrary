(* mono-array.fun
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

functor MonoArrayExtFn (
    structure A : MONO_ARRAY
    structure V : MONO_VECTOR
      sharing type A.elem = V.elem
      sharing type A.vector = V.vector
  ) : MONO_ARRAY_EXT =
  struct

    open A

    fun toList arr = List.tabulate(length arr, fn i => sub(arr, i))

    fun fromVector vec = tabulate (V.length vec, fn i => V.sub(vec, i))

    val toVector = vector

  end
