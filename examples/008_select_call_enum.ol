let add = (a: int, b: int) <> int {
    a + b
}

let sub = (a: int, b: int) <> int {
    a - b
}

let parse_int = (input: string) <> Result<int, string> {
    match int::parse(input) {
        Ok(n) -> Ok(n)
        Err(e) -> Err("Invalid number '{{input}}': {{e}}")
    }
}

enum Operation {
    Add,
    Sub
}

let parse_operation = (input: string) <> Result<Operation, string> {
    match input.trim() {
        "add" -> Ok(Operation::Add)
        "sub" -> Ok(Operation::Sub)
        other -> Err("Unknown operation: {{other}}")
    }
}

let perform = (op: Operation, a: int, b: int) <> int {
    match op {
        Operation::Add -> add(a, b)
        Operation::Sub -> sub(a, b)
    }
}

let main = () <$stdin, $stdout> Result<(), string> {
    val input = readln("Enter two numbers separated by a space: ")
    val parts = input.trim().split(" ")
    
    if parts.len() != 2 {
        return "Error: Please enter exactly two numbers."
    }
    
    val a = parse_int(parts[0])?
    val b = parse_int(parts[1])?
    
    val operation_input = readln("Choose an operation (add/sub): ")
    val op = parse_operation(operation_input.trim())?
    
    val result = perform(op, a, b)
    
    println("Result: {{result}}")
    Ok(())
}
