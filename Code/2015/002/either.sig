(* either.sig
 *
 * ============================================================================
 * Copyright (c) 2015 John Reppy (http://cs.uchicago.edu/~jhr)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * ============================================================================
 *
 * Reference code for SML Basis Library Proposal 2015-002.
 *)

signature EITHER =
  sig

    datatype ('left, 'right) either = INL of 'left | INR of 'right

    val isLeft : ('left, 'right) either -> bool
    val isRight : ('left, 'right) either -> bool

    val asLeft : ('left, 'right) either -> 'left option
    val asRight : ('left, 'right) either -> 'right option

    val map  : ('ldom -> 'lrng) * ('rdom -> 'rrng)
                -> ('ldom, 'rdom) either
                  -> ('lrng, 'rrng) either

    val app  : ('left -> unit) * ('right -> unit)
                -> ('left, 'right) either
                  -> unit

    val fold : ('left * 'b -> 'b) * ('right * 'b -> 'b)
                -> 'b -> ('left, 'right) either -> 'b

    val proj : ('a, 'a) either -> 'a

    val partition : (('left, 'right) either) list -> ('left list * 'right list)

  (* added 2016-08-10 *)
    val mapLeft  : ('ldom -> 'lrng) -> ('ldom, 'rdom) either -> ('lrng, 'rdom) either
    val mapRight : ('rdom -> 'rrng) -> ('ldom, 'rdom) either -> ('ldom, 'rrng) either

    val appLeft  : ('left -> unit) -> ('left, 'right) either -> unit
    val appRight : ('right -> unit) -> ('left, 'right) either -> unit

  end
