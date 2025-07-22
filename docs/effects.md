# Effects

## Reference

- [Interfaces](https://wasi.dev/interfaces#wasi-02)

## Full list of Olion effects - opt-in WASI

- `$env`
- `$random`
- `$stdio` _(collective effect)_
  - `$stdin`
  - `$stdout`
  - `$stderr`
- `$clock` _(collective effect)_
  - `$monoclock`
  - `$wallclock`
  - `$timezone`
- `$fs` _(collective effect)_
  - `$fsread`
  - `$fswrite`
  - `$fscreate`
  - `$fsdelete`
- `$ip` _(collective effect)_
  - `$ipclient`
  - `$ipserver`
- `$http` _(collective effect)_
  - `$httpclient`
  - `$httpserver`

## Automatically activated WASI interfaces
- always
  - [`cli/run`](https://github.com/WebAssembly/wasi-cli/blob/main/wit/run.wit)
  - [`cli/exit`](https://github.com/WebAssembly/wasi-cli/blob/main/wit/exit.wit)
- when `$ipclient` or `$ipserver` is activated
  - [Sockets](https://github.com/WebAssembly/wasi-sockets)
- when `$httpclient` or `$httpserver` is activated
  - [Sockets](https://github.com/WebAssembly/wasi-sockets)
  - [HTTP](https://github.com/WebAssembly/wasi-http)
  
## Effect Capabilities

Configure by `[capabilities]` table in `olion.toml` at the root of your project:

```toml
[capabilities]
env = ["NAME_1", "NAME_2", ] # environment variables that your application can access

random = true # enable random number generation

stdin = true # enable reading from stdin
stdout = true # enable writing to stdout
stderr = true # enable writing to stderr
# or
stdio = true # enable all of stdin, stdout, stderr

monoclock = true # enable reading from monotonic clock
wallclock = true # enable reading from wall clock
timezone = true # enable reading timezone information
# or
clock = true # enable all of monoclock, wallclock, timezone

fsread = ["path1", "path2", ] # paths that your application can read from
fswrite = ["path1", "path2", ] # paths that your application can write to
fscreate = ["path1", "path2", ] # paths that your application can create files in
fsdelete = ["path1", "path2", ] # paths that your application can delete files from
# or
fs = ["path1", "path2", ] # paths that your application can do any file operations on

ipclient = ["address1", "address2", ] # addresses that your application can connect to as a client
ipserver = ["address1", "address2", ] # addresses that your application can bind to as a server
# or
ip = ["address1", "address2", ] # addresses that your application can do any IP operations on

httpclient = ["address1", "address2", ] # addresses that your application can connect to as an HTTP client
httpserver = ["address1", "address2", ] # addresses that your application can bind to as an HTTP server
# or
http = ["address1", "address2", ] # addresses that your application can do any HTTP operations on
```

Olion applications are:

- **never** compiled unless capabilities of all effects of the entry point (e.g. `main` function)
  are specified.
- **always** checks program's capabilities at runtime, and fails if the program tries something
  that is not allowed by the capabilities (e.g. reading from a file not allowed by `fsread` capability).
