(* list-pair.sig
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
 * Reference code for SML Basis Library Proposal 2015-003.
 *)

signature LIST_PAIR_EXT =
  sig

    include LIST_PAIR

    val appi		: (int * 'a * 'b -> unit) -> 'a list * 'b list -> unit
    val appiEq		: (int * 'a * 'b -> unit) -> 'a list * 'b list -> unit
    val mapi		: (int * 'a * 'b -> 'c) -> 'a list * 'b list -> 'c list
    val mapiEq		: (int * 'a * 'b -> 'c) -> 'a list * 'b list -> 'c list
    val mapPartial	: ('a * 'b -> 'c option) -> 'a list * 'b list -> 'c list
    val mapPartialEq	: ('a * 'b -> 'c option) -> 'a list * 'b list -> 'c list
    val mapPartiali	: (int * 'a * 'b -> 'c option) -> 'a list * 'b list -> 'c list
    val mapPartialiEq	: (int * 'a * 'b -> 'c option) -> 'a list * 'b list -> 'c list
    val foldli		: (int * 'a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c
    val foldliEq	: (int * 'a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c
    val foldri		: (int * 'a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c
    val foldriEq	: (int * 'a * 'b * 'c -> 'c) -> 'c -> 'a list * 'b list -> 'c

  end
