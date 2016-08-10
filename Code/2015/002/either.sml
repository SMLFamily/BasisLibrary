(* either.sml
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

structure Either : EITHER =
  struct

    datatype ('left, 'right) either = INL of 'left | INR of 'right

    fun isLeft (INL _) = true
      | isLeft (INR _) = false
    fun isRight (INL _) = false
      | isRight (INR _) = true

    fun asLeft (INL x) = SOME x
      | asLeft (INR _) = NONE
    fun asRight (INL _) = NONE
      | asRight (INR x) = SOME x

    fun map (fl, fr) sum = (case sum
           of INL x => INL(fl x)
            | INR x => INR(fr x)
          (* end case *))

    fun mapLeft fl sum = map (fl, fn x => x) sum
    fun mapRight fr sum = map (fn x => x, fr) sum

    fun app (fl, fr) sum = (case sum
           of INL x => fl x
            | INR x => fr x
          (* end case *))

    fun appLeft fl sum = app (fl, fn x => ()) sum
    fun appRight fr sum = app (fn x => (), fr) sum

    fun fold (fl, fr) init sum = (case sum
           of INL x => fl (x, init)
            | INR x => fr (x, init)
          (* end case *))

    fun proj (INL x) = x
      | proj (INR x) = x

    fun partition sums = let
          fun lp ([], ls, rs) = (List.rev ls, List.rev rs)
            | lp ((INL x)::sums, ls, rs) = lp (sums, x::ls, rs)
            | lp ((INR x)::sums, ls, rs) = lp (sums, ls, x::rs)
          in
            lp (sums, [], [])
          end

  end
