(* ref.sml
 *
 * Reference code for SML Basis Library Proposal 2015-007.
 *)

structure Ref : REF =
  struct

    datatype ref = datatype ref

    val ! = General.!
    val op := = General.:=

    fun exchange (r as ref x, y) = (r := x; y)
    fun swap (rx as ref x, ry as ref y) = (rx := y; ry := x)

    fun app f (ref x) = f x

    fun map f (ref x) = ref (f x)

    fun modify f (r as ref x) = r := f x

  end
