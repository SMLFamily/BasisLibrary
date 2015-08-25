## Proposal yyyy-ddd
### Addition of `Counter` module

**Author:** Some Author<br/>
**Last revised:** August 25, 2015<br/>
**Status:** proposed<br/>
**Discussion:** [issue #XX](https://github.com/SMLFamily/BasisLibrary/issues/XX)<br/>

***

#### Synopsis
```sml
signature COUNTER
structure Counter :> COUNTER
```

\[_Here we include a short summary of the proposed API and what its purpose is._]

This module provides stateful counters for counting things.

#### Interface

```sml
type cntr

datatype oper = INC | DEC

exception Underflow

val new    : unit -> cntr
val update : cntr * oper -> unit
val read   : cntr -> IntInf.int
```

#### Description

* `type cntr`<br/>
is the abstract type of counters.

* `datatype oper = INC | DEC`<br/>
  defines the operations that can be performed on a counter:
  * `INC` is the increment operator
  * `DEC` is the decrement operator

* `exception Underflow`<br/>
is raised if performing a decrement on a counter would cause it to go below zero.

* `new ()`<br/>
returns a new counter.

* `update (cntr, oper)`<br/>
modifies the state of the counter `cntr` by applying the operation `oper` to the counter.
The `Underflow` exception is raised when a decrement operation is applied to a counter
whose value is zero.

* `read cntr`<br/>
returns the current value of the counter.

#### Discussion

\[_A discussion of the design choices and possible alternatives._]

It might be useful to provide `inc` and `dec` functions.

#### Impact

\[_What impact will this proposal have on existing code?_]

Adding this module will not affect existing code.

#### Rationale

\[_Why is the proposed API a candidate for the Basis Library (as opposed to some other
library).  Why do we need it?_]

Counting things is important; this module will help support that common task.

***

### History

* [2015-08-25] Proposed

***