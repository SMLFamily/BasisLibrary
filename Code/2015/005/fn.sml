(* fn.sml
 *
 * Reference code for SML Basis Library Proposal 2015-005.
 *)

structure Fn : FN =
  struct

    fun id x = x

    fun const x y = x

    fun apply (f, x) = f x

    val op o = General.o

    fun curry f x y = f(x, y)

    fun uncurry f (x, y) = f x y

    fun flip f (x, y) = f (y, x)

    fun repeat n = if (n < 0)
	  then raise Domain
	  else (fn f => let
	    fun repeatF (0, x) = x
	      | repeatF (n, x) = repeatF (n-1, f x)
	    in
	      fn x => repeatF (n, x)
	    end)

  end
