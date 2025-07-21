let add = (a: int, b: int) <> int {
    a + b
}

let sub = (a: int, b: int) <> int {
    a - b
}

enum SelectCallError {
    UnexpectedNumberOfInputs(int)
    InvalidInteger(string)
    UnknownOperation(string)
}

impl Error for SelectCallError {
    let message = (self) <> string {
        match self {
            Self::UnexpectedNumberOfInputs(count) -> "Error: Please enter exactly two numbers, but got {{count}}."
            Self::InvalidInteger(input) -> "Invalid number '{{input}}'."
            Self::UnknownOperation(op) -> "Unknown operation: {{op}}."
        }
    }
}

let parse_int = (input: string) <> Result<int, SelectCallError> {
    match int::parse(input) {
        Ok(n) -> Ok(n)
        Err(e) -> Err(SelectCallError::InvalidInteger(input))
    }
}

record Inputs {
    a: int
    b: int
}

let parse_inputs = (input: string) <> Result<Inputs, SelectCallError> {
    val parts = input.trim().split(" ")
    
    if parts.len() != 2 {
        return Err(SelectCallError::UnexpectedNumberOfInputs(parts.len()))
    }
    
    val a = parse_int(parts[0])?
    val b = parse_int(parts[1])?
    
    Ok(Inputs { a, b })
}

enum Operation {
    Add
    Sub
}

let parse_operation = (input: string) <> Result<Operation, SelectCallError> {
    match input.trim() {
        "add" -> Ok(Operation::Add)
        "sub" -> Ok(Operation::Sub)
        other -> Err(SelectCallError::UnknownOperation(other))
    }
}

let perform = (op: Operation, in: Inputs) <> int {
    match op {
        Operation::Add -> add(in.a, in.b)
        Operation::Sub -> sub(in.a, in.b)
    }
}

let main = () <$stdin, $stdout> Result<(), SelectCallError> {
    val input = readln("Enter two numbers separated by a space: ")
    val inputs = parse_inputs(input)?
    
    val operation_input = readln("Choose an operation (add/sub): ")
    val op = parse_operation(operation_input.trim())?
    
    val result = perform(op, a, b)
    
    println("Result: {{result}}")
    Ok(())
}
