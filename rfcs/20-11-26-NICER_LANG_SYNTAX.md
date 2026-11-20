# RFC: Improve Function Signatures, Effect Requirements, and Variable Declarations

**Status:** Draft  
**Type:** Language Design  
**Scope:** Syntax and developer experience

## Summary

This RFC proposes three syntax improvements to Olion:

1. Introduce a more explicit and readable syntax for function effect requirements.
2. Make effect operations discoverable through explicit namespaces and qualified names.
3. Replace the existing `val` / `let` variable declaration keywords with the more widely recognized `let` / `var` convention.

The primary objective is to improve readability, writability, and developer tooling support without changing the underlying language semantics or its approach to algebraic effects.

## Motivation

Olion's current syntax can make certain language features unnecessarily difficult to discover and use.

Consider the following example:

```ol
let foo = () void <$stdin> {
    readln()
}
```

Although this may be valid, it introduces several usability concerns:

- `readln()` appears without an explicit namespace or visible origin.
- The relationship between the operation and the `$stdin` effect is not immediately apparent.
- Discoverability is limited: developers cannot easily identify where an operation originates.
- LSP tooling has fewer explicit syntactic references to leverage for completion, navigation, and contextual assistance.
- The syntax requires developers to understand the effect context before understanding the operation itself.

The goal is not to make effects less explicit, but to make their requirements and origins easier to understand.

## Proposal

### 1. Explicit function effect requirements

Introduce an effect requirement clause in function signatures.

**Proposed syntax:**

```ol
fn name() <returnT> |:io::{stdin}| {
    stdin.readln
}
```

The proposed structure is:

```ol
fn <name>(<parameters>) <return_type> |:<effect_requirements>" {
    <body>
}
```

Effect requirements should be declared directly in the function signature rather than being left implicit in the function body.

For example:

```ol
fn read_input() string |:io::{stdin}| {
    stdin.readln
}
```

This makes the function's dependencies visible before examining its implementation.

#### Qualified effect operations

Effect operations should be accessed through their respective namespaces.

Instead of:

```ol
readln()
```

Prefer:

```ol
stdin.readln
```

This establishes a visible relationship between an operation and its originating effect.

It also provides a more predictable basis for IDE features:

- Autocomplete effect operations through their namespace.
- Navigate to operation declarations.
- Inspect available operations through completion.
- Identify missing or incompatible effect requirements.
- Provide contextual diagnostics for unresolved operations.

### 2. Variable declaration keywords

Replace the existing `val` / `let` convention with `let` / `var`.

**Proposed convention:**

```ol
let name = "Olion"
var counter = 0
```

- `let`: immutable binding.
- `var`: mutable binding.

The motivation is familiarity and accessibility.

The `let` / `var` convention is already established across several widely used programming languages and ecosystems. Adopting it reduces the conceptual overhead for developers transitioning from other languages.

It also avoids introducing an unfamiliar distinction between `val` and `let` when more recognizable alternatives already exist.

## Design Principles

These changes follow three principles:

**Explicitness over implicitness**

A function's dependencies should be visible in its declaration. Operations should have identifiable origins.

**Readability over syntactic novelty**

Syntax should be understandable without requiring developers to learn an entirely new set of conventions when established alternatives are available.

**Tooling as a first-class concern**

The language's syntax should expose enough structure for LSP implementations to provide meaningful completion, navigation, diagnostics, and contextual assistance.

## Open Questions

1. Should effect requirements be inherited, propagated, or explicitly declared at every function boundary?
2. Should effect operations always require namespace qualification ?

## Expected Outcome

A more approachable language surface that retains Olion's underlying design while improving the everyday programming experience.

The intended result is simple: developers should be able to understand what a function does, what it requires, and where its operations originate without having to reconstruct that information from its implementation.
