(* word.sml
 *
 * ============================================================================
 * Copyright (c) 2016 John Reppy (http://cs.uchicago.edu/~jhr)
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
 * Reference code for SML Basis Library Proposal 2016-001.
 *)

structure WordExt : WORD_EXT =
  struct

    open Word

  (* population count.  See below for more efficient straight-line implementations
   * for specific word sizes.
   *)
    fun popCount w = let
          fun cnt (0w0, i) = i
            | cnt (w, i) = cnt (>>(w, 0w1), if (andb(w, 0w1) <> 0w0) then i+1 else i)
          in
            cnt (w, 0)
          end

  (* the following straight-line version works for 32-bit words and only uses addition,
   * logical and, and shift operations
    fun popCount (w : Word32.word) = let
        (* pop count of each 2 bits into those 2 bits *)
          val w = w - Word32.andb(Word32.>>(w, 0w1), 0wx55555555)
        (* pop count of each 4 bits into those 4 bits *)
          val w = Word32.andb(w, 0wx33333333) + Word32.andb(Word32.>>(w, 0w2), 0wx33333333)
        (* pop count of each 8 bits into those 8 bits *)
          val w = Word32.andb(w + Word32.>>(w, 0w4), 0wx0F0F0F0F)
        (* pop count of each 16 bits into their lowest 8 bits *)
          val w = w + Word32.>>(w, 0w8)
        (* pop count of each 32 bits into their lowest 8 bits *)
          val w = w + Word32.>>(w, 0w16)
          in
          (* mask out result *)
            Word32.toIntX (Word32.andb(w, 0wx3F))
          end
   *)

  (* the following straight-line version works for 32-bit words, but requires a fast
   * multiply instruction
    fun popCount (w : Word32.word) = let
        (* pop count of each 2 bits into those 2 bits *)
          val w = w - Word32.andb(Word32.>>(w, 0w1), 0wx55555555)
        (* pop count of each 4 bits into those 4 bits *)
          val w = Word32.andb(w, 0wx33333333) + Word32.andb(Word32.>>(w, 0w2), 0wx33333333)
        (* pop count of each 8 bits into those 8 bits *)
          val w = Word32.andb(w + Word32.>>(w, 0w4), 0wx0F0F0F0F)
          in
          (* return leftmost 8 bits of w + (w<<8) + (w<<16) + (w<<24) *)
            Word32.toIntX (Word32.>>(w * 0wx01010101, 0w24))
          end
   *)

  (* the following straight-line version works for 64-bit words and only uses addition,
   * logical and, and shift operations
    fun popCount (w : Word64.word) = let
        (* pop count of each 2 bits into those 2 bits *)
          val w = w - Word64.andb(Word64.>>(w, 0w1), 0wx5555555555555555)
        (* pop count of each 4 bits into those 4 bits *)
          val w = Word64.andb(w, 0wx3333333333333333)
                + Word64.andb(Word64.>>(w, 0w2), 0wx3333333333333333)
        (* pop count of each 8 bits into those 8 bits *)
          val w = Word64.andb(w + Word64.>>(w, 0w4), 0wx0F0F0F0F0F0F0F0F)
        (* pop count of each 16 bits into their lowest 8 bits *)
          val w = w + Word64.>>(w, 0w8)
        (* pop count of each 32 bits into their lowest 8 bits *)
          val w = w + Word64.>>(w, 0w16)
        (* pop count of each 64 bits into their lowest 8 bits *)
          val w = w + Word64.>>(w, 0w32)
          in
          (* mask out result *)
            Word64.toIntX (Word64.andb(w, 0wx7F))
          end
   *)


  (* the following straight-line version works for 64-bit words, but requires a fast
   * multiply instruction
    fun popCount (w : Word64.word) = let
        (* pop count of each 2 bits into those 2 bits *)
          val w = w - Word64.andb(Word64.>>(w, 0w1), 0wx5555555555555555)
        (* pop count of each 4 bits into those 4 bits *)
          val w = Word64.andb(w, 0wx3333333333333333)
                + Word64.andb(Word64.>>(w, 0w2), 0wx3333333333333333)
        (* pop count of each 8 bits into those 8 bits *)
          val w = Word64.andb(w + Word64.>>(w, 0w4), 0wx0F0F0F0F0F0F0F0F)
          in
          (* return leftmost 8 bits of w + (w<<8) + (w<<16) + (w<<24) + ... + (w<<56) *)
            Word64.toIntX (Word64.>>(w * 0wx0101010101010101, 0w56))
          end
   *)

  end
