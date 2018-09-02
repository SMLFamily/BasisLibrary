(* array-slice.sml
 *
 * ============================================================================
 * Copyright (c) 2018 John Reppy (http://cs.uchicago.edu/~jhr)
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
 * Reference code for SML Basis Library Proposal 2018-002.
 *)

structure ArraySliceExt : ARRAY_SLICE_EXT =
  struct

    open ArraySlice

    fun triml n s = if (n < length s)
	  then subslice(s, n, NONE)
	  else subslice(s, length s, NONE)

    fun trimr n s = if (n < length s)
	  then subslice(s, 0, SOME(length s - n))
	  else subslice(s, 0, SOME 0)

    fun splitAt (s, i) = (subslice(s, 0, SOME i), subslice(s, i, NONE))

    fun getVec (s, n) = if (n < length s)
	  then let
	    val (s1, s2) = splitAt (s, n)
	    in
	      SOME(vector s1, s2)
	    end
	  else NONE

  end
