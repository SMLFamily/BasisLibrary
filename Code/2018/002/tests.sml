(* tests.sml
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
 * Test suite for SML Basis Library Proposal 2018-002.
 *)

structure CharArraySliceExt = MonoArraySliceExtFn(CharArraySlice)

structure CharVectorSliceExt = MonoVectorSliceExtFn(CharVectorSlice)

structure Tests =
  struct

    local
      open Check
      structure SS = Substring
      fun triml (v, n) () = SS.string(CharVectorSlice.triml n (SS.full v))
      fun trimr (v, n) () = SS.string(CharVectorSlice.trimr n (SS.full v))
      fun splitAt (v, n) () = let
	    val (vs1, vs2) = CharVectorSlice.splitAt(SS.full v, n)
	    in
	      (SS.string vs1, SS.string vs2)
	    end
      fun getVec (v, n) () = Option.map
	    (fn (v, r) => (v, SS.string r))
	      (CharVectorSlice.getVec (SS.full v, n))
    in

    fun testCVS () = runSuite "CharVectorSlice" (fn test => (
        (* test triml *)
	  test "triml-1" (expectSubscript (triml ("abc", ~1)));
	  test "triml-2" (expectStr "" (triml ("", 0)));
	  test "triml-3" (expectStr "abc" (triml ("abc", 0)));
	  test "triml-4" (expectStr "bc" (triml ("abc", 1)));
	  test "triml-5" (expectStr "" (triml ("abc", 3)));
	  test "triml-6" (expectStr "" (triml ("abc", 4)));
        (* test trimr *)
	  test "trimr-1" (expectSubscript (trimr ("abc", ~1)));
	  test "trimr-2" (expectStr "" (trimr ("", 0)));
	  test "trimr-3" (expectStr "abc" (trimr ("abc", 0)));
	  test "trimr-4" (expectStr "ab" (trimr ("abc", 1)));
	  test "trimr-5" (expectStr "" (trimr ("abc", 3)));
	  test "trimr-6" (expectStr "" (trimr ("abc", 4)));
        (* test splitAt *)
	  test "splitAt-1" (expectSubscript (splitAt ("abcxyz", ~1)));
	  test "splitAt-2" (expectSubscript (splitAt ("abcxyz", 7)));
	  test "splitAt-3" (expectVal' ("", "") (splitAt ("", 0)));
	  test "splitAt-4" (expectVal' ("", "abcxyz") (splitAt ("abcxyz", 0)));
	  test "splitAt-5" (expectVal' ("a", "bcxyz") (splitAt ("abcxyz", 1)));
	  test "splitAt-6" (expectVal' ("abc", "xyz") (splitAt ("abcxyz", 3)));
	  test "splitAt-7" (expectVal' ("abcxy", "z") (splitAt ("abcxyz", 5)));
	  test "splitAt-8" (expectVal' ("abcxyz", "") (splitAt ("abcxyz", 6)));
        (* test getVec *)
	  test "getVec-1" (expectSubscript (getVec ("abcdef", ~1)));
	  test "getVec-2" (expectNone (getVec ("abcxyz", 7)));
	  test "getVec-3" (expectSome' ("", "") (getVec ("", 0)));
	  test "getVec-4" (expectSome' ("", "abcxyz") (getVec ("abcxyz", 0)));
	  test "getVec-5" (expectSome' ("a", "bcxyz") (getVec ("abcxyz", 1)));
	  test "getVec-6" (expectSome' ("abc", "xyz") (getVec ("abcxyz", 3)));
	  test "getVec-7" (expectSome' ("abcxy", "z") (getVec ("abcxyz", 5)));
	  test "getVec-8" (expectSome' ("abcxyz", "") (getVec ("abcxyz", 6)));
          ()))

    end (* local *)

    local
      open Check
      fun slice v = CharArraySlice.full (CharArray.fromVector v)
      val vector = CharArraySlice.vector
      fun triml (v, n) () = vector(CharArraySlice.triml n (slice v))
      fun trimr (v, n) () = vector(CharArraySlice.trimr n (slice v))
      fun splitAt (v, n) () = let
	    val (vs1, vs2) = CharArraySlice.splitAt(slice v, n)
	    in
	      (vector vs1, vector vs2)
	    end
      fun getVec (v, n) () = Option.map
	    (fn (v, r) => (v, vector r))
	      (CharArraySlice.getVec (slice v, n))
fun eq ((a : string, b : string), (a', b')) =
if (a = a') andalso (b = b') then true
else (print(concat["(\"", a, "\", \"", b, "\") <> (\"", a', "\", \"", b', "\")\n"]); false)
    in

    fun testCAS () = runSuite "CharArraySlice" (fn test => (
        (* test triml *)
	  test "triml-1" (expectSubscript (triml ("abc", ~1)));
	  test "triml-2" (expectStr "" (triml ("", 0)));
	  test "triml-3" (expectStr "abc" (triml ("abc", 0)));
	  test "triml-4" (expectStr "bc" (triml ("abc", 1)));
	  test "triml-5" (expectStr "" (triml ("abc", 3)));
	  test "triml-6" (expectStr "" (triml ("abc", 4)));
        (* test trimr *)
	  test "trimr-1" (expectSubscript (trimr ("abc", ~1)));
	  test "trimr-2" (expectStr "" (trimr ("", 0)));
	  test "trimr-3" (expectStr "abc" (trimr ("abc", 0)));
	  test "trimr-4" (expectStr "ab" (trimr ("abc", 1)));
	  test "trimr-5" (expectStr "" (trimr ("abc", 3)));
	  test "trimr-6" (expectStr "" (trimr ("abc", 4)));
        (* test splitAt *)
	  test "splitAt-1" (expectSubscript (splitAt ("abcxyz", ~1)));
	  test "splitAt-2" (expectSubscript (splitAt ("abcxyz", 7)));
	  test "splitAt-3" (expectVal eq ("", "") (splitAt ("", 0)));
	  test "splitAt-4" (expectVal eq ("", "abcxyz") (splitAt ("abcxyz", 0)));
	  test "splitAt-5" (expectVal eq ("a", "bcxyz") (splitAt ("abcxyz", 1)));
	  test "splitAt-6" (expectVal eq ("abc", "xyz") (splitAt ("abcxyz", 3)));
	  test "splitAt-7" (expectVal eq ("abcxy", "z") (splitAt ("abcxyz", 5)));
	  test "splitAt-8" (expectVal eq ("abcxyz", "") (splitAt ("abcxyz", 6)));
        (* test getVec *)
	  test "getVec-1" (expectSubscript (getVec ("abcdef", ~1)));
	  test "getVec-2" (expectNone (getVec ("abcxyz", 7)));
	  test "getVec-3" (expectSome' ("", "") (getVec ("", 0)));
	  test "getVec-4" (expectSome' ("", "abcxyz") (getVec ("abcxyz", 0)));
	  test "getVec-5" (expectSome' ("a", "bcxyz") (getVec ("abcxyz", 1)));
	  test "getVec-6" (expectSome' ("abc", "xyz") (getVec ("abcxyz", 3)));
	  test "getVec-7" (expectSome' ("abcxy", "z") (getVec ("abcxyz", 5)));
	  test "getVec-8" (expectSome' ("abcxyz", "") (getVec ("abcxyz", 6)));
          ()))

    end (* local *)

(*
    fun testVS () = runSuite "VectorSlice" (fn test => (
        (* test triml *)
        (* test trimr *)
        (* test splitAt *)
        (* test getVec *)
          ()))

    fun testAS () = runSuite "ArraySlice" (fn test => (
        (* test triml *)
        (* test trimr *)
        (* test splitAt *)
        (* test getVec *)
          ()))
*)

  end
