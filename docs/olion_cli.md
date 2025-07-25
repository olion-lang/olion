# `olion` CLI

## Components

- Compiler: validate entrypoint effects with referencing `olion.toml`, then
  convert `.ol`s to `.wasm`, a Wasm Component
- Capabilities Adaptor: generate and link an adaptor component
  intercepting application's WASI calls and enforcing defined capabilities
  (inspired by [`bytecodealliance/WASI-Virt`](https://github.com/bytecodealliance/WASI-Virt))
- Linker: built-in [`wasm-tools compose`](https://github.com/bytecodealliance/wasm-tools)
- Optimizer: built-in [`wasm-opt`](https://github.com/WebAssembly/binaryen)
- Runtime: built-in [`wasmtime`](https://github.com/bytecodealliance/wasmtime)

## Subcommands

- `build` - for an application component (having a `main` function)
  - 1) Resolve import/exports between modules and parse `.ol` codes into an Olion AST.
  - 2) Validate entire the project codebase based on `olion.toml` manifest.
  - 3) Convert the AST into a Wasm Component `.wasm`.
  - 4) Generate capabilities-adaptor component based on `olion.toml` that
       knows capabilities configuration for the application component,
       and intercepts WASI calls from application as needed to enforce required capabilities.
  - 5) Link application and adaptor components into single `.wasm`.
- `run` - for an application component (having a `main` function)
  - 1) Do `build` and get component `.wasm`.
  - 2) Run the component on built-in `wasmtime`, with automatically configuring required options for `wasmtime`.
    
### Note

When you need to run an Olion application binary `.wasm` in other way than `olion run`,
such as `wasmtime run`, `wasmer run`, etc., you have to pass all CLI arguments
corresponded to WASI calls of the application component.
Note that you don't need to concern around the detailed capabilities configured in `olion.toml`
at that time, and just each-runtime's options like `--env NAME=VAL --dir ./tmp::/app` are needed:
the detailed capabilities are encoded into the application binary itself.
