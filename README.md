# Standard ML Basis Library

This repository and associated [wiki](https://github.com/SMLFamily/BasisLibrary/wiki) provides a platform for managing changes to the [Standard ML Basis Library](http://sml-family.org/Basis/) specification.

## Scope
The SML Basis Library was purposefully designed to be limited in its scope.  Specifically, it included features that satisified one of the following properties:

- features that required special compiler support, such as strings and arrays.
- features that require an interface to the host operating system, such as sockets and file-system access.
- features that are more concise or efficient than an equivalent combination of other features.
- features that have clear or proven utility or were part of previous versions of the SML Basis (*e.g.*, the SML'90 Basis).

These properties are meant to serve as guidelines for what belongs in the Basis Library, instead of in an utility or application-specific library.

## Conventions
Proposals for new Basis Library modules should follow the coding conventions used in the published version of the original specification.  These conventions are

- Alphanumeric value identifiers are in mixed-case, with a leading lowercase letter; *e.g.*, `map` and `openIn`.
- Type identifiers are all lowercase, with words separated by underscores; *e.g.*, `word` and `file_desc`.
- Signature identifiers are in all capitals, with words  separated by underscores; *e.g.*, `PACK_WORD` and `OS_PATH`.  We refer to this convention as the *signature* convention.
- Structure and functor identifiers are in mixed-case, with initial letters  of words capitalized; *e.g.*, `General` and `WideChar`. We refer to this convention as the *structure* convention.
- Alphanumeric datatype constructors follow the signature convention; *e.g.*, `SOME`, `A_READ`, and `FOLLOW_ALL`. In certain cases, where external usage or aesthetics dictates otherwise, the structure convention can be used. Within the Basis library, the only use of the latter convention occurs with the months and weekdays in `Date`, *e.g.*, `Jan` and `Mon`.
  The one exception to this rule are the traditional constructors `nil`, `true`, and `false`.
- Exception identifiers follow the structure convention; *e.g.*, `Domain` and `SysErr`.

## Process
We need to develop a process for how to handling proposals.  Issues include

- what should a proposal contain
- how should proposals be submitted (is there an editor?)
- how to resolve discussion and approve a proposal

One possible model is the [SRFI](http://srfi.schemers.org) process.
