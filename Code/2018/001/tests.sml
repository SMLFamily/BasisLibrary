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
 * Test suite for SML Basis Library Proposal 2018-001.
 *)

structure Tests =
  struct

    local
      open Check
      open CharBuffer
      fun ident x = x
      val itos = Int.toString
      fun withBuf n f () = let
            val buf = new n
            in
              f buf
            end
      fun withBufContents n f () = let
            val buf = new n
            in
              f buf; contents buf
            end
      structure SS = Substring
    in

    fun run () = runSuite "CharBuffer" (fn test => (
        (* test new *)
          test "new-1" (expectSize (fn () => new ~1));
          test "new-2" (expectSize (fn () => new(maxLen+1)));
          test "new-3" (expect (fn _ => true) (fn () => new 0));
          test "new-4" (expect (fn _ => true) (fn () => new 2));
        (* test contents *)
          test "contents-1" (expectStr "" (withBuf 0 contents));
          test "contents-2" (expectStr "" (withBuf 2 contents));
          test "contents-3" (expectStr "x"
                (withBuf 8 (fn buf => (add1(buf, #"x"); contents buf))));
        (* test length *)
          test "length-1" (expectInt 0 (withBuf 0 length));
          test "length-2" (expectInt 0 (withBuf 2 length));
          test "length-3" (expectInt 1
                (withBuf 8 (fn buf => (add1(buf, #"x"); length buf))));
        (* test clear *)
          test "clear-1" (expectStr "" (withBufContents 8 clear));
          test "clear-2" (expectStr "" (withBufContents 8
                (fn buf => (add1(buf, #"x"); clear buf))));
          test "clear-3" (expectStr "ab" (withBufContents 8
                (fn buf => (addVec(buf, "xyz"); clear buf; addVec(buf, "ab")))));
        (* test reset *)
          test "reset-1" (expectStr "" (withBufContents 8 reset));
          test "reset-2" (expectStr "" (withBufContents 8
                (fn buf => (add1(buf, #"x"); reset buf))));
          test "reset-3" (expectStr "ab" (withBufContents 8
                (fn buf => (addVec(buf, "xyz"); reset buf; addVec(buf, "ab")))));
        (* test reserve *)
          test "reserve-1" (expectSize (withBuf 8 (fn buf => reserve(buf, ~1))));
          test "reserve-2" (expectStr "xy"
                (withBufContents 4
                  (fn buf => (add1(buf, #"x"); reserve(buf, 1024); add1(buf, #"y")))));
        (* test add1 *)
          test "add1-1" (expectStr "xyz"
                (withBufContents 1
                  (fn buf => (add1(buf, #"x"); add1(buf, #"y"); add1(buf, #"z")))));
          test "add1-2" (expectStr "xyz"
                (withBufContents 8
                  (fn buf => (add1(buf, #"x"); add1(buf, #"y"); add1(buf, #"z")))));
        (* test addVec *)
          test "addVec-1" (expectStr "xyz"
                (withBufContents 8 (fn buf => addVec(buf, "xyz"))));
          test "addVec-2" (expectStr "xyzabc"
                (withBufContents 8 (fn buf => (addVec(buf, "xyz"); addVec(buf, "abc")))));
        (* test addSlice *)
          test "addSlice-1" (expectStr "xyz"
                (withBufContents 8 (fn buf => addSlice(buf, SS.full "xyz"))));
          test "addSlice-2" (expectStr "xyz"
                (withBufContents 8
                  (fn buf => (addSlice(buf, SS.substring("012xyzabc", 3, 3))))));
        (* test addArr *)
          test "addArr-1" (expectStr "xyz"
                (withBufContents 8 (fn buf => let
                  val arr = Array.fromList(String.explode "xyz")
                  in
                    addSlice(buf, SS.full "xyz")
                  end)));
        (* test addArrSlice *)
          test "addArrSlice-1" (expectStr "xyz"
                (withBufContents 8 (fn buf => let
                  val arr = CharArray.fromList(String.explode "xyz")
                  in
                    addArrSlice(buf, CharArraySlice.full arr)
                  end)));
          test "addArrSlice-2" (expectStr "xyz"
                (withBufContents 8 (fn buf => let
                  val arr = CharArray.fromList(String.explode "012xyzabc")
                  in
                    addArrSlice(buf, CharArraySlice.slice(arr, 3, SOME 3))
                  end)));
          ()))

    end (* local *)

  end
