(* check.sml
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
 * Support code for testing Basis Library reference implementations.
 *)

structure Check : sig

  (* the checked result of a test.  Either ok, failure because of the wrong value
   * being returned, or failure because of an unexpected exception being raised.
   *)
    datatype result = OK | FAIL | RAISE of exn

  (* convert a result to a string *)
    val toString : result -> string

  (* `expect pred tst` takes a predicate and a test. It runs the test and
   * returns
   *	OK	  if the function returns a value that satisfies the predicate
   *	FAIL	  if the function returns a value that fails the predicate
   *	RAISE ex  if the function raises the exception ex
   *)
    val expect : ('a -> bool) -> (unit -> 'a) -> unit -> result

  (* `expectVal eq v tst` takes an equality test, an expected value, and a test.
   * It runs the test and checks the result against the expected value.
   *)
    val expectVal : ('a * 'a -> bool) -> 'a -> (unit -> 'a) -> unit -> result

  (* like expectVal, except that it only works on equality types *)
    val expectVal' : ''a -> (unit -> ''a) -> unit -> result

  (* expects for common types *)
    val expectTrue : (unit -> bool) -> unit -> result
    val expectFalse : (unit -> bool) -> unit -> result
    val expectStr : string -> (unit -> string) -> unit -> result
    val expectInt : int -> (unit -> int) -> unit -> result
    val expectWrd : word -> (unit -> word) -> unit -> result
    val expectNone : (unit -> 'a option) -> unit -> result
    val expectSome : ('a * 'a -> bool) -> 'a -> (unit -> 'a option) -> unit -> result
    val expectSome' : ''a -> (unit -> ''a option) -> unit -> result
    val expectNil : (unit -> 'a list) -> unit -> result
    val expectList : ('a * 'a -> bool) -> 'a list -> (unit -> 'a list) -> unit -> result

  (* `expectExn isExn tst` takes a predicate on exceptions and a test.
   * It runs the test and returns
   *	OK	  if the function raises an exception that satisfies the predicate
   *	FAIL	  if the function returns a value
   *	RAISE ex  if the function raises an exception ex that does not satisfy the predicate
   *
   * It runs the test and returns "ok" if an exception was raised that
   * satisfies the predicate.  Otherwise it returns "fail".
   *)
    val expectExn : (exn -> bool) -> (unit -> 'a) -> unit -> result

  (* expects for many of the basis exceptions *)
    val expectSubscript : (unit -> 'a) -> unit -> result
    val expectSize : (unit -> 'a) -> unit -> result
    val expectOverflow : (unit -> 'a) -> unit -> result
    val expectChr : (unit -> 'a) -> unit -> result
    val expectDiv : (unit -> 'a) -> unit -> result
    val expectDomain : (unit -> 'a) -> unit -> result
    val expectSpan : (unit -> 'a) -> unit -> result
    val expectOption : (unit -> 'a) -> unit -> result

  (* a wrapper for testing imperative functions using a reference as the state.
   *
   *	withRef init tst
   *
   * builds a test is equivalent to
   *
   *	let val r = ref init in tst r; !r end
   *)
    val withRef : 'a -> ('a ref -> unit) -> unit -> 'a

  (* a suite provides a context for the tests associated with a given module *)
    type suite

  (* create a suite for the named module that reports results to standard output *)
    val new : string -> suite

  (* create a suite for the named module that reports results to the file module.results.
   * The boolean flag controls the verbosity of the output; if true, then only summary
   * results are reported.
   *)
    val new' : string * bool -> suite

  (* report the results for the suite; if the suite has an associated output file, then
   * the file is closed after reporting the results.
   *)
    val report : suite -> unit

  (* a general function for running a test in a given suite.  Some typical uses are
   *
   *	test "Option" "getOpt-1" (expectInt 42 (fn () => getOpt(SOME 42, 17)))
   *	test "Option" "getOpt-2" (expectInt 17 (fn () => getOpt(NONE, 17)))
   *    test "Option" "valOf-1" (expectOption (fn () => valOf NONE))
   *
   * which will produce the output
   *
   *	Option.getOpt-1 ok
   *	Option.getOpt-2 ok
   *	Option.valOf-1 ok
   *)
    val test : suite -> string -> (unit -> result) -> unit

  (* `runSuite module runTests` creates a suite `s`, applies `runTests` to `test s`, and
   * then reports the results.
   *)
    val runSuite : string -> ((string -> (unit -> result) -> unit) -> unit) -> unit

  end = struct

    datatype result = OK | FAIL | RAISE of exn

    fun toString OK = "ok"
      | toString FAIL = "fail"
      | toString (RAISE ex) = String.concat["fail[", General.exnName ex, "]"]

    datatype 'a return = VAL of 'a | EXN of exn

  (* run a test returning a result *)
    fun run tst = VAL(tst()) handle ex => EXN ex

    fun expect chk tst () = (case run tst
	   of VAL v => if chk v then OK else FAIL
	    | EXN ex => RAISE ex
	  (* end case *))

  (* some expects for common types *)
    fun expectVal eq v = expect (fn v' => eq(v, v'))
    fun expectVal' v = expect (fn v' => (v = v'))
    val expectTrue = expect (fn x => x)
    val expectFalse = expect Bool.not
    fun expectStr (s : string) = expectVal (op =) s
    fun expectInt (i : int) = expectVal (op =) i
    fun expectWrd (w : word) = expectVal (op =) w
    fun expectNone tst = expect (fn NONE => true | _ => false) tst
    fun expectSome eq v = expect (fn SOME v' => eq(v, v') | _ => false)
    fun expectSome' v = expect (fn SOME v' => (v = v') | _ => false)
    fun expectNil tst = expect (fn [] => true | _ => false) tst
    fun expectList eq = expectVal (ListPair.allEq eq)

    fun expectExn chk tst () = (case run tst
	   of VAL v => FAIL
	    | EXN ex => if chk ex then OK else RAISE ex
	  (* end case *))

  (* expects for many of the basis exceptions *)
    fun expectSubscript tst = expectExn (fn General.Subscript => true | _ => false) tst
    fun expectSize tst = expectExn (fn General.Size => true | _ => false) tst
    fun expectOverflow tst = expectExn (fn General.Overflow => true | _ => false) tst
    fun expectChr tst = expectExn (fn General.Chr => true | _ => false) tst
    fun expectDiv tst = expectExn (fn General.Div => true | _ => false) tst
    fun expectDomain tst = expectExn (fn General.Domain => true | _ => false) tst
    fun expectSpan tst = expectExn (fn General.Span => true | _ => false) tst
    fun expectOption tst = expectExn (fn Option.Option => true | _ => false) tst

  (* support for testing imperative operations *)
    fun withRef init tst () = let val r = ref init in tst r; !r end

  (* a suite provides a context for the tests associated with a given module *)
    datatype suite = Suite of {
	module : string,		(* the module name *)
	outS : TextIO.outstream option,	(* NONE is stdOut *)
	quiet : bool,			(* if true, then only summary results are reported *)
	nTests : int ref,		(* the number of tests run *)
	nFails : int ref,		(* the number of tests that returned the wrong result *)
	nExns : int ref			(* the number of tests that raised an exception *)
      }

    fun streamOf strmOpt = getOpt (strmOpt, TextIO.stdOut)

    fun pr (strmOpt, s) = TextIO.output (streamOf strmOpt, s)

    fun flush strmOpt = TextIO.flushOut (streamOf strmOpt)

    fun create (module, strm, q) = (
	  if q then () else pr (strm, String.concat["** Testing ", module, "\n"]);
	  Suite{
	      module = module,
	      outS = strm,
	      quiet = q,
	      nTests = ref 0,
	      nFails = ref 0,
	      nExns = ref 0
	    })

  (* create a suite for the named module that reports results to standard output *)
    fun new module = create (module, NONE, false)

  (* create a suite for the named module that reports results to the file module.results *)
    fun new' (module, quiet) = create (
	  module,
	  SOME(TextIO.openOut(OS.Path.joinBaseExt{base=module, ext=SOME "results"})),
	  quiet)

  (* report the results for the suite; if the suite has an associated output file, then
   * the file is closed after reporting the results.
   *)
    fun report (Suite{module, outS, nTests, nFails, nExns, ...}) = let
	  val nBad = !nFails + !nExns
	  in
	    if !nTests = 0
	      then pr(outS, "!! no tests\n")
	      else (
		pr(outS, String.concat[
		    "** Summary for ", module, ": ", Int.toString(!nTests), " tests; ",
		    Int.toString(!nTests - nBad), " passed"
		  ]);
		if nBad > 0
		  then pr(outS, String.concat["; ", Int.toString nBad, " falures\n"])
	          else pr(outS, "\n"));
	    Option.app TextIO.closeOut outS 
	  end

  (* run a named test and report the result *)
    fun test suite = let
	  val Suite{module, outS, quiet, nTests, nFails, nExns, ...} = suite
	  fun inc (r as ref n) = r := n+1
	  fun test' name tst = (
		if quiet
		  then ()
		  else (
		    pr(outS, StringCvt.padRight #" " 40 (String.concat["-- ", module, ".", name, " "]));
		    flush outS);
		inc nTests;
		case tst ()
		 of OK => if quiet then () else pr(outS, "ok\n")
		  | FAIL => (inc nFails; if quiet then () else pr(outS, "fail\n"))
		  | (RAISE ex) => (
		      inc nExns;
		      if quiet then () else pr(outS, String.concat["fail[", General.exnName ex, "]\n"])))
	  in
	    test'
	  end
	  
    fun runSuite module runTests = let
	  val suite = new' (module, false)
	  in
	    runTests (test suite);
	    report suite
	  end

  end
