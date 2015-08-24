(* list-pair.sml
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

structure ListPairExt : LIST_PAIR_EXT =
  struct

    open ListPair

    fun appi f (l1, l2) = let
	  fun appf (i, x::xs, y::ys) = (f(i, x, y); appf(i+1, xs, ys))
	    | appf _ = ()
	  in
	    appf (0, l1, l2)
	  end

    fun appiEq f (l1, l2) = let
	  fun appf (i, x::xs, y::ys) = (f(i, x, y); appf(i+1, xs, ys))
	    | appf (_, [], []) = ()
	    | appf _ = raise UnequalLengths
	  in
	    appf (0, l1, l2)
	  end

    fun mapi f (l1, l2) = let
	  fun mapf (i, x::xs, y::ys, zs) = (mapf(i+1, xs, ys, f(i, x, y) :: zs))
	    | mapf (_, _, _, zs) = List.rev zs
	  in
	    mapf (0, l1, l2, [])
	  end

    fun mapiEq f (l1, l2) = let
	  fun mapf (i, x::xs, y::ys, zs) = (mapf(i+1, xs, ys, f(i, x, y) :: zs))
	    | mapf (_, [], [], zs) = List.rev zs
	    | mapf _ = raise UnequalLengths
	  in
	    mapf (0, l1, l2, [])
	  end

    fun mapPartial f (l1, l2) = let
	  fun mapf (x::xs, y::ys, acc) = (case f(x, y)
		 of SOME z => mapf(xs, ys, z::acc)
		  | NONE => mapf(xs, ys, acc)
		(* end case *))
	    | mapf (_, _, acc) = List.rev acc
	  in
	    mapf (l1, l2, [])
	  end
 
    fun mapPartialEq f (l1, l2) = let
	  fun mapf (x::xs, y::ys, acc) = (case f(x, y)
		 of SOME z => mapf(xs, ys, z::acc)
		  | NONE => mapf(xs, ys, acc)
		(* end case *))
	    | mapf ([], [], acc) = List.rev acc
	    | mapf _ = raise UnequalLengths
	  in
	    mapf (l1, l2, [])
	  end

    fun mapPartiali f (l1, l2) = let
	  fun mapf (i, x::xs, y::ys, acc) = (case f(i, x, y)
		 of SOME z => mapf(i+1, xs, ys, z::acc)
		  | NONE => mapf(i+1, xs, ys, acc)
		(* end case *))
	    | mapf (_, _, _, acc) = List.rev acc
	  in
	    mapf (0, l1, l2, [])
	  end
 
    fun mapPartialiEq f (l1, l2) = let
	  fun mapf (i, x::xs, y::ys, acc) = (case f(i, x, y)
		 of SOME z => mapf(i+1, xs, ys, z::acc)
		  | NONE => mapf(i+1, xs, ys, acc)
		(* end case *))
	    | mapf (_, [], [], acc) = List.rev acc
	    | mapf _ = raise UnequalLengths
	  in
	    mapf (0, l1, l2, [])
	  end

    fun foldli f init (l1, l2) = let
	  fun foldf (i, x::xs, y::ys, acc) = foldf (i+1, xs, ys, f(i, x, y, acc))
	    | foldf (_, _, _, acc) = acc
	  in
	    foldf (0, l1, l2, init)
	  end

    fun foldliEq f init (l1, l2) = let
	  fun foldf (i, x::xs, y::ys, acc) = foldf (i+1, xs, ys, f(i, x, y, acc))
	    | foldf (_, [], [], acc) = acc
	    | foldf _ = raise UnequalLengths
	  in
	    foldf (0, l1, l2, init)
	  end

    fun foldri f init (l1, l2) = let
          fun lp (i, x::xs, y::ys) = f (i, x, y, lp (i+1, xs, ys))
	    | lp (_, _, _) = init
	  in
	    lp (0, l1, l2)
	  end

    fun foldriEq f init (l1, l2) = let
          fun lp (i, x::xs, y::ys) = f (i, x, y, lp (i+1, xs, ys))
	    | lp (_, [], []) = init
	    | lp _ = raise UnequalLengths
	  in
	    lp (0, l1, l2)
	  end

  end
