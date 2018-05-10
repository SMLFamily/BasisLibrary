(* mono-buffer.sml
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

structure Word8Buffer : MONO_BUFFER
                          where type elem = Word8.word
			    and type vector = Word8Vector.vector
			    and type slice = Word8VectorSlice.slice
			    and type array = Word8Array.array
			    and type array_slice = Word8ArraySlice.slice
  = MonoBufferFn (
      structure V = Word8Vector
      structure VS = Word8VectorSlice
      structure A = Word8Array
      structure AS = Word8ArraySlice
      val defaultElem : Word8.word = 0w0
    );

structure CharBuffer : MONO_BUFFER
                          where type elem = Char.char
			    and type vector = CharVector.vector
			    and type slice = CharVectorSlice.slice
			    and type array = CharArray.array
			    and type array_slice = CharArraySlice.slice
  = MonoBufferFn (
      structure V = CharVector
      structure VS = CharVectorSlice
      structure A = CharArray
      structure AS = CharArraySlice
      val defaultElem : Char.char = #"\000"
    );
