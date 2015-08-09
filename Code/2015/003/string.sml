(* string.sml
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

structure StringExt : STRING_EXT =
  struct

    open String

    val rev = implode o List.rev o explode
    val implodeRev = implode o List.rev
    fun concatWithMap sep f l = concatWith sep (List.map f l)

  end
