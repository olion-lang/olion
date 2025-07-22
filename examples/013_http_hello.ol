import std::net::http::{Request, Response, serve}

let main = () <$stdout, $stderr, $net> {
    let hello = (req: Request) <> Response {
        let name = req.query("name").unwrap_or("world")
        Response::new({
            status: 200,
            body: "Hello, {{name}}!",
            headers: { content_type: "text/plain" }
        })
    }
    
    println("Starting server on http://localhost:8080")
    serve(hello, "localhost:8080").unwrap_or_else(|e| {
        eprintln("Failed to start server: {{e}}")
    })
}
