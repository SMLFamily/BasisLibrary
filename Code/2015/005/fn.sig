(* fn.sig
 *
 * Reference code for SML Basis Library Proposal 2015-005.
 *)

signature FN =
  sig

    val id      : 'a -> 'a
    val const   : 'a -> 'b -> 'a
    val apply   : ('a -> 'b) * 'a -> 'b
    val o       : ('b -> 'c) * ('a -> 'b) -> ('a -> 'c)
    val curry   : ('a * 'b -> 'c) -> ('a -> 'b -> 'c)
    val uncurry : ('a -> 'b -> 'c) -> ('a * 'b -> 'c)
    val flip    : ('a * 'b -> 'c) -> ('b * 'a -> 'c)
    val repeat  : int -> ('a -> 'a) -> ('a -> 'a)

  end