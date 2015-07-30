# Standard ML Basis Library

This repository and associated wiki provides a platform for managing changes to the [Standard ML Basis Library](http://sml-family.org/Basis/) specification.

## Scope
The SML Basis Library was purposefully designed to be limited in its scope.  Specifically, it only included three kinds of components:

- features that required special compiler support, such as strings and arrays.
- features that require an interface to the host operating system, such as sockets and file-system access.
- features that had a been part of previous versions of the SML Basis (*e.g.*, the SML'90 Basis).

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
We plan to use a process similar to that of the [SFRI](http://srfi.schemers.org).
