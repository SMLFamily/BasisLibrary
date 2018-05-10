(* mono-buffer.sig
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
 * Reference code for SML Basis Library Proposal 2018-001.
 *
 * This proposal supersedes 2015-004.
 *)

signature MONO_BUFFER =
  sig

    type buf

    type elem
    type vector
    type slice
    type array
    type array_slice

    val maxLen : int

    val new : int -> buf

    val contents : buf -> vector

    val length : buf -> int

    val clear : buf -> unit

    val reset : buf -> unit

    val reserve : buf * int -> unit

    val add1 : buf * elem -> unit
    val addVec : buf * vector -> unit
    val addSlice : buf * slice -> unit
    val addArr : buf * array -> unit
    val addArrSlice : buf * array_slice -> unit

  end
