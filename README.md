<p align="center">THIS IS CURRENTLY <strong>JUST AN IDEA</strong>.</p>
<p align="center">THERE's ONLY <strong>WRITING-IN-PROGRESS DRAFT</strong>S, AND <strong>NO WORKING THINGS</strong>.</p>
<p align="center">PLEASE WAIT FOR OUR INITIAL RELEASE!</p>

<br/><hr/><br/>

<header><div align="center">
<img
  src="https://raw.githubusercontent.com/olion-lang/assets/refs/heads/main/olion-header.png"
/>
<br/>
<h1>
  Olion - A programming language with effect system on Wasm Component Model
</h1>
</div></header>

<br/>

<div align="center">
<p>(<i><strong>fully writing in progress</strong></i>...)</p>
</div>

<br/>

## Why Olion?

- **Static Effect Tracking**: All side effects of Olion program may causes are
  statically checked by the type system.
- **Capability-Based Security**: Olion's effects (`$stdout`, `$fsread`, ...) are
  seamlessly mapped to WASI, and their detailed capabilities are checked in runtime.
- **Portability**: Olion applications are built into Wasm Components, running on
  any Wasm runtimes that supports Wasm Component Model.

## License

Olion is licensed under [MIT LICENSE](https://github.com/olion-lang/olion/blob/main/LICENSE).
