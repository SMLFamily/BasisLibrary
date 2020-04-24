(* tests.sml
 *
 * ============================================================================
 * Copyright (c) 2020 John Reppy (http://cs.uchicago.edu/~jhr)
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
 * Test suite for SML Basis Library Proposal 2015-007.
 *)

structure Tests =
  struct

    local
      open Check
      open Ref
      fun expectIntInt (p : (int * int)) = expectVal (op =) p
      fun expectIntString (p : (int * string)) = expectVal (op =) p
      fun withRefPair (init1, init2) tst () = let
	    val r1 = ref init1
	    val r2 = ref init2
	    in
	      tst (r1, r2);
	      (!r1, !r2)
	    end
    in

    fun run () = runSuite "Ref" (fn test => (
	(* test exchange *)
	  test "exchange" (expectIntInt (42, 17) (fn () => let
	    val r = ref 17
	    val x = exchange(r, 42)
	    in
	      (!r, x)
	    end));
	(* test swap *)
	  test "swap" (expectIntInt (42, 17) (withRefPair (17, 42) swap));
	(* test app : ('a -> unit) -> 'a ref -> unit *)
	  test "app" (expectIntString (42, "42") (withRefPair (42, "")
	    (fn (r, res) => app (fn n => res := Int.toString n) r)));
	(* test map : ('a -> 'b) -> 'a ref -> 'b ref *)
	  test "map" (expectIntString (42, "42") (fn () => let
	    val r = ref 42
	    val res = map Int.toString r
	    in
	      (!r, !res)
	    end));
	(* test modify *)
	  test "modify" (expectInt 18 (withRef 17 (fn r => modify (fn x => x+1) r)));
	  ()))

    end (* local *)

  end
