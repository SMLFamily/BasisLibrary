(* option.sml
 *
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

structure OptionExt : OPTION_EXT =
  struct

    open Option

    fun isNone NONE = true
      | isNone _ = false

    fun fold f init NONE = init
      | fold f init (SOME x) = f(x, init);

  end
