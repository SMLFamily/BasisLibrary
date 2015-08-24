(* tests.sml
 *
 * Test suite for SML Basis Library Proposal 2015-001.
 *)

structure Tests =
  struct

    local
      open Check
      open ListPair
      exception TestExn
      fun expectUnequal tst = expectExn (fn UnequalLengths => true | _ => false) tst
      fun expectTestExn tst = expectExn (fn TestExn => true | _ => false) tst
      fun raiseTestExn _ = raise TestExn
      val expectIntPairList =
	    expectList (fn ((x1 : int, y1 : int), (x2, y2)) => (x1 = x2) andalso (y1 = y2))
      val l1 = [1, 2, 3]
      val l2 = [1, 2, 3, 4]
      fun consp (x, y, xys) = (x, y) :: xys
    in

    fun run () = runSuite "ListPair" (fn test => (
	(* test appEq *)
	  test "appEq-1" (
	    expectIntPairList [(3, 3), (2, 2), (1, 1)] (withRef [] (fn r =>
	      appEq (fn (a, b) => r := (a, b) :: !r) (l1, l1))));
	  test "appEq-2" (
	    expectUnequal (withRef [] (fn r =>
	      appEq (fn (a, b) => r := (a, b) :: !r) (l1, l2))));
	  test "appEq-3" (
	    expectUnequal (withRef [] (fn r =>
	      appEq (fn (a, b) => r := (a, b) :: !r) (l2, l1))));
	  test "appEq-4" (expectTestExn (fn () => appEq raiseTestExn (l1, l2)));
	  test "appEq-5" (expectTestExn (fn () => appEq raiseTestExn (l2, l1)));
	  test "appEq-6" (expectUnequal (fn () => appEq raiseTestExn ([], l2)));
	  test "appEq-7" (expectUnequal (fn () => appEq raiseTestExn (l2, [])));
	(* test mapEq *)
	  test "mapEq-1" (expectIntPairList [(1, 1), (2, 2), (3, 3)]
	    (fn () => mapEq (fn xy => xy) (l1, l1)));
	  test "mapEq-2" (expectUnequal (fn () => mapEq (fn xy => xy) (l1, l2)));
	  test "mapEq-3" (expectUnequal (fn () => mapEq (fn xy => xy) (l2, l1)));
	  test "mapEq-4" (expectTestExn (fn () => mapEq raiseTestExn (l1, l2)));
	  test "mapEq-5" (expectTestExn (fn () => mapEq raiseTestExn (l2, l1)));
	  test "mapEq-6" (expectUnequal (fn () => mapEq raiseTestExn ([], l2)));
	  test "mapEq-7" (expectUnequal (fn () => mapEq raiseTestExn (l2, [])));
	(* test foldlEq *)
	  test "foldlEq-1" (
	    expectIntPairList [(3, 3), (2, 2), (1, 1)] (fn () => foldlEq consp [] (l1, l1)));
	  test "foldlEq-2" (expectUnequal (fn () => foldlEq consp [] (l1, l2)));
	  test "foldlEq-3" (expectUnequal (fn () => foldlEq consp [] (l2, l1)));
	  test "foldlEq-4" (expectTestExn (fn () => foldlEq raiseTestExn [] (l1, l2)));
	  test "foldlEq-5" (expectTestExn (fn () => foldlEq raiseTestExn [] (l2, l1)));
	  test "foldlEq-6" (expectUnequal (fn () => foldlEq raiseTestExn [] ([], l2)));
	  test "foldlEq-7" (expectUnequal (fn () => foldlEq raiseTestExn [] (l2, [])));
	(* test foldrEq *)
	  test "foldrEq-1" (
	    expectIntPairList [(1, 1), (2, 2), (3, 3)] (fn () => foldrEq consp [] (l1, l1)));
	  test "foldrEq-2" (expectUnequal (fn () => foldrEq consp [] (l1, l2)));
	  test "foldrEq-3" (expectUnequal (fn () => foldrEq consp [] (l2, l1)));
	  test "foldrEq-4" (expectUnequal (fn () => foldrEq raiseTestExn [] (l1, l2)));
	  test "foldrEq-5" (expectUnequal (fn () => foldrEq raiseTestExn [] (l2, l1)));
	  test "foldrEq-6" (expectUnequal (fn () => foldrEq raiseTestExn [] ([], l2)));
	  test "foldrEq-7" (expectUnequal (fn () => foldrEq raiseTestExn [] (l2, [])));
	  ()))

    end (* local *)

  end
