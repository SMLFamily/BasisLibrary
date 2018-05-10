(* mono-buffer.fun
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

functor MonoBufferFn (

    structure V : MONO_VECTOR
    structure VS : MONO_VECTOR_SLICE
      where type elem = V.elem and type vector = V.vector
    structure A : MONO_ARRAY
      where type elem = V.elem and type vector = V.vector
    structure AS : MONO_ARRAY_SLICE
      where type elem = V.elem and type array = A.array
        and type vector = V.vector and type vector_slice = VS.slice
    val defaultElem : V.elem

  ) : MONO_BUFFER = struct

    type elem = V.elem
    type vector = V.vector
    type slice = VS.slice
    type array = A.array
    type array_slice = AS.slice

    datatype buf = BUF of {
	content : array ref,	(* array for holding content *)
	len : int ref,		(* current length of content *)
	initLen : int		(* initial size *)
      }

  (* default initial size *)
    val defaultInitLen = 4096

    val maxLen = Int.min(V.maxLen, A.maxLen)

    fun new hint = let
	  val n = if (hint < 0) orelse (V.maxLen < hint)
	  	then raise Size
		else if (hint = 0) then defaultInitLen
		else hint
	  in
	    BUF{
		content = ref(A.array(n, defaultElem)),
		len = ref 0,
		initLen = n
	      }
	  end

    fun contents (BUF{content=ref arr, len=ref n, ...}) =
	  AS.vector (AS.slice (arr, 0, SOME n))

    fun length (BUF{len=ref n, ...}) = n

    fun clear (BUF{len, ...}) = (len := 0)

    fun reset (BUF{content, len, initLen}) = (
	  len := 0;
	  if (A.length(!content) <> initLen)
	    then content := A.array(initLen, defaultElem)
	    else ())

  (* ensure that the content array has space for amt elements *)
    fun ensureCapacity (content, len, amt) = let
	  val capacity = (len + amt) handle Overflow => maxLen
	  in
	    if (A.length(!content) < capacity)
	      then let
		val newArr = A.array(capacity, defaultElem)
		in
		  AS.copy{dst = newArr, di = 0, src = AS.slice(!content, 0, SOME len)};
		  content := newArr
		end
	      else ()
	  end

    fun reserve (_, 0) = ()
      | reserve (BUF{content, len=ref len, ...}, n) =
	  if (n < 0) then raise Size
	  else ensureCapacity (content, len, n)

    fun add1 (BUF{content, len, ...}, elem) = (
	  ensureCapacity(content, !len, 1);
	  A.update(!content, !len, elem);
	  len := !len + 1)

    fun addVec (BUF{content, len, ...}, vec) = (
	  ensureCapacity(content, !len, V.length vec);
	  A.copyVec{dst = !content, di = !len, src = vec};
	  len := !len + V.length vec)

    fun addSlice (BUF{content, len, ...}, slice) = (
	  ensureCapacity(content, !len, VS.length slice);
	  AS.copyVec{dst = !content, di = !len, src = slice};
	  len := !len + VS.length slice)

    fun addArr (BUF{content, len, ...}, arr) = (
	  ensureCapacity(content, !len, A.length arr);
	  A.copy{dst = !content, di = !len, src = arr};
	  len := !len + A.length arr)

    fun addArrSlice (BUF{content, len, ...}, slice) = (
	  ensureCapacity(content, !len, AS.length slice);
	  AS.copy{dst = !content, di = !len, src = slice};
	  len := !len + AS.length slice)

  end
