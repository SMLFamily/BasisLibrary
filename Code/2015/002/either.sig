(* either.sig
 *
 * Reference code for SML Basis Library Proposal 2015-002.
 *)

signature EITHER =
  sig

    datatype ('left, 'right) either = INL of 'left | INR of 'right

    val isLeft : ('left, 'right) sum -> bool
    val isRight : ('left, 'right) sum -> bool

    val asLeft : ('left, 'right) sum -> 'left option
    val asRight : ('left, 'right) sum -> 'right option

    val map : ('ldom -> 'lrng) * ('rdom -> 'rrng)
	      -> ('ldom, 'rdom) sum
		-> ('lrng, 'rrng) sum
    val app : ('left -> unit) * ('right -> unit)
	      -> ('left, 'right) sum
		-> unit

    val partition : (('left, 'right) sum) list -> ('left list * 'right list)

  end
