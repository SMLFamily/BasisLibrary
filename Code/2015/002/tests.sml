(* tests.sml
 *
 * Test suite for SML Basis Library Proposal 2015-002.
 *)

structure Tests =
  struct

    local
      open Check
      open Either
      fun ident x = x
      val itos = Int.toString
    in

    fun run () = runSuite "Either" (fn test => (
	(* test isLeft *)
	  test "isLeft-1" (expectTrue (fn () => isLeft (INL 1)));
	  test "isLeft-2" (expectFalse (fn () => isLeft (INR 1)));
	(* test isRight *)
	  test "isRight-1" (expectTrue (fn () => isRight (INR 1)));
	  test "isRight-2" (expectFalse (fn () => isRight (INL 1)));
	(* test asLeft *)
	  test "asLeft-1" (expectSome' 1 (fn () => asLeft (INL 1)));
	  test "asLeft-2" (expectNone (fn () => asLeft (INR 1)));
	(* test asRight *)
	  test "asRight-1" (expectSome' 1 (fn () => asRight (INR 1)));
	  test "asRight-2" (expectNone (fn () => asRight (INL 1)));
	(* test map *)
	  test "map-1" (expectVal' (INL "17") (fn () => map (itos, itos) (INL 17)));
	  test "map-2" (expectVal' (INR "17") (fn () => map (itos, itos) (INR 17)));
	  test "map-3" (expectVal' (INL 17) (fn () => map (ident, itos) (INL 17)));
	  test "map-4" (expectVal' (INR "17") (fn () => map (ident, itos) (INR 17)));
	(* test app *)
	  test "app-1" (expectVal' "17"
		(withRef "" (fn r => app (fn x => r := itos x, fn x => r := itos x) (INL 17))));
	  test "app-2" (expectVal' "17"
	    (withRef "" (fn r => app (fn x => r := itos x, fn x => r := itos x) (INR 17))));
	  test "app-3" (expectVal' "16"
	    (withRef "" (fn r => app (fn x => r := itos(x-1), fn x => r := itos(x+1)) (INL 17))));
	  test "app-4" (expectVal' "18"
	    (withRef "" (fn r => app (fn x => r := itos(x-1), fn x => r := itos(x+1)) (INR 17))));
	(* test fold *)
	  test "fold-1" (expectInt 16 (fn () => fold (Int.-, Int.+) 1 (INL 17)));
	  test "fold-2" (expectInt 18 (fn () => fold (Int.-, Int.+) 1 (INR 17)));
	  test "fold-3" (expectInt 18 (fn () => fold (Int.+, Int.-) 1 (INL 17)));
	  test "fold-4" (expectInt 16 (fn () => fold (Int.+, Int.-) 1 (INR 17)));
	(* test proj *)
	  test "proj-1" (expectInt 17 (fn () => proj (INL 17)));
	  test "proj-2" (expectInt 42 (fn () => proj (INR 42)));
	(* test partition *)
	  test "partition-1" (expect (fn ([], []) => true | _ => false) (fn () => partition []));
	  test "partition-2" (expect (fn ([17], []) => true | _ => false) (fn () => partition [INL 17]));
	  test "partition-3" (expect (fn ([], [42]) => true | _ => false) (fn () => partition [INR 42]));
	  test "partition-4" (expect (fn ([17], [42]) => true | _ => false) (fn () => partition [INL 17, INR 42]));
	  test "partition-5" (expect (fn ([42], [17]) => true | _ => false) (fn () => partition [INR 17, INL 42]));
	  test "partition-6" (expect
		(fn ([13, 42], [17, 99]) => true | _ => false)
		(fn () => partition [INL 13, INR 17, INR 99, INL 42]));
	  ()))

    end (* local *)

  end
