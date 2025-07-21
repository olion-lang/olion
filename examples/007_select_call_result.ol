let add = (a: int, b: int) <> int {
    a + b
}

let sub = (a: int, b: int) <> int {
    a - b
}

let parse_int = (input: string) <> Result[int, string] {
    match int::parse(input) {
        Ok(n) -> Ok(n)
        Err(e) -> Err("Invalid number '{{input}}': {{e}}")
    }
}

let app = () <$stdin, $stdout> Result[(), string] {
    val input = readln("Enter two numbers separated by a space: ")
    val parts = input.trim().split(" ")
    
    if parts.len() != 2 {
        return "Error: Please enter exactly two numbers."
    }
    
    val a = parse_int(parts[0])?
    val b = parse_int(parts[1])?
    
    val operation = readln("Choose an operation (add/sub): ")
    
    val result = match operation.trim() {
        "add" -> add(a, b)
        "sub" -> sub(a, b)
        other -> return "Error: Unknown operation: {{other}}"
    }
    
    println("Result: {{result}}")
    Ok(())
}

let main = () <$stdin, $stdout, $stderr> {
    match app() {
        Ok(_) -> ()
        Err(e) -> eprintln("Error: {{e}}")
    }
}
