(* mono-vector.fun
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

functor MonoVectorExtFn (V : MONO_VECTOR) : MONO_VECTOR_EXT =
  struct

    open V

    fun toList v = List.tabulate(length v, fn i => sub(v, i))

    fun append (v, x) = concat[v, fromList[x]]

    fun prepend (x, v) = concat[fromList[x], v]

  end
