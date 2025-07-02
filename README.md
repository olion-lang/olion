<p align="center">THIS IS CURRENTLY <strong>JUST AN IDEA</strong>.</p>
<p align="center">THERE's ONLY <strong>WRITING-IN-PROGRESS DRAFT</strong>S, AND <strong>NO WORKING THINGS</strong>.</p>
<p align="center">PLEASE WAIT FOR OUR INITIAL RELEASE!</p>

<br/><hr/><br/>

<header><div align="center">
<img
    src="https://raw.githubusercontent.com/olion-lang/assets/refs/heads/main/olion-header.png"
    width="66.7%"
/>
<h1>
    Olion - A programming language with Algebraic Effects on WASI.
</h1>
</div></header>

<br/>

<div align="center">
<p>(<i><strong>writing in progress</strong></i>...)</p>
</div>

<br/>

## Why Olion?

- **Static Effect Tracking**: All side effects of Olion program may causes are statically checked by type system.
- **Capability-based Security**: Olion's builtin effects (stdout, fsread, ...) are seamlessly mapped to WASI interface, and their capabilities are securely checked by Wasm runtime.
- **Expressiveness**: Algebraic Effects enables, at program design, more than async/await, more than trait/protocol, and more clean way of free monad/handler.
- **Portability**: Olion applications are built into Wasm Components, running on any runtimes that supprts Wasm Component Model.

## Syntax Overview

`$effect`s are described later.

```rust
let var_1: TypeName = expression1 // `;` is not required

let var_2 = expression2 // omitting type annotation when can inferred

let mut var_3 = expression3 // mutable veraible

fn function_1(arg1: Type1, arg2: Type2, ...) <$effect1, $effect2, ...> ReturnType {
    // statements using $effect1,2...
    expression //: ReturnType, returned from this function
}

// builtin types like `int`, `uint`, `string`, ... are
// named in lower_case, while user-defined types are in PascalCase.

fn add(a: uint, b: uint) uint {// omitting `<>`, an empty effect list
    a + b
}

fn hello(message: string) <$stdout> {// omitting `()`, unit type returned
    // shadowing `message`
    let message = "Hello! {{message}}" // string interpolation
    $stdout.println(message) // performing `println` of `$stdout` effect
}

// visible to outer world of the module
pub fn util_method(a: string) string {
    a
}
```

## Effect Basic

Effect is the only way to perform side effects in Olion. If a function has
no or an empty effect list in its signature, Olion assures that the function is **pure**.

### syntax

```rust
// definition, effect name must be prefixed by `$`
effect $EffectName {
    fn operation_1()
    fn operation_2(arg: string) -> TypeName
}

// user
fn hello() <$EffectName> {
    $EffectName.operation_1();
}

// handler
fn parent() <$stdout> {
    handle hello() {// handling `$EffectName` effect here, so it's disappeared in the signature
        $EffectName.operation_1() -> $stdout.println("Hello, effect!") // using `$stdout` effect here,
        $EffectName.operation_2(arg) -> $stdout.println("Hello, effect with {{arg}}!") // so the signature has it
    }
}
```

### builtin effects

Olion provides following builtin effects, mapped to [WASI 0.2](https://wasi.dev/interfaces#wasi-02) API:

- `$monoclock`
- `$wallclock`
- `$timezone`
- `$random`
- `$insecurerandom`
- `$insecureseed`
- `$fsread`
- `$fswrite`
- `$fsmanage`
- `$iplookup`
- `$tcpmanage`
- `$tcpclient`
- `$tcpmanage`
- `$udpclient`
- `$udpserver`
- `$udpclient`
- `$udpmanage`
- `$httpclient`
- `$httpserver`
- `$env`
- `$exit`
- `$stdin`
- `$stdout`

except for `$actor` effect, described laster.

`main` function can have only these builtin effects in its signature:

```rust
// OK
fn main() <$stdout> {
    $stdout.println("Hello, Olion!")
}
```

```rust
effect $MyEffect {
    $do_something() -> uint
}

// Compile Error: main function can't have user-defined effect `$MyEffect`
fn main() <$stdout, $MyEffect> {
    let result = $MyEffect.do_something()
    $stdout.println("got result: {{result}}")
}
```

Operations and mapping of each builtin effects are described in [builtin_effects.md](./docs/builtin_effects.md).

### actor / channel

In Olion, concurrent processing are archieved by `$actor` and `$channel` special builtin effect:

```rust
fn main() <$stdout, $actor, $channel> {
    let data = [1, 2, 3, 5, 8, 13, 21, 34]

    let sum1 = $actor.spawn<Option<uint>, uint>(fn() {
        let mut sum = 0
        loop {
            match $actor.recv() {
                Some(v) -> sum += v
                None -> break
            }
        }
        sum
    })

    let sum2 = $actor.spawn(fn() {
        let mut sum = 0
        loop {
            match $actor.recv() {
                Some(v) -> sum += v
                None -> break
            }
        }
        sum
    })


}
```

## License

Olion is licensed under [MIT LICENSE](https://github.com/olion-lang/olion/blob/main/LICENSE).
