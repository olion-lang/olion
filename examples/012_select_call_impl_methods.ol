enum SelectCallError {
    UnexpectedNumberOfInputs(int)
    InvalidInteger(string)
    UnknownOperation(string)
}

impl Display for SelectCallError {
    let display = (self) <> string {
        match self {
            Self::UnexpectedNumberOfInputs(count) -> "Error: Please enter exactly two numbers, but got {{count}}."
            Self::InvalidInteger(input) -> "Invalid number '{{input}}'."
            Self::UnknownOperation(op) -> "Unknown operation: {{op}}."
        }
    }
}

let parse_int = (input: string) <> Result[int, SelectCallError] {
    match int::parse(input) {
        Ok(n) -> Ok(n)
        Err(e) -> Err(SelectCallError::InvalidInteger(input))
    }
}

record Inputs {
    a: int
    b: int
}

impl Inputs {
    let new = (input: string) <> Result[Self, SelectCallError] {
        val parts = input.trim().split(" ")
        
        if parts.len() != 2 {
            return Err(SelectCallError::UnexpectedNumberOfInputs(parts.len()))
        }
        
        val a = parse_int(parts[0])?
        val b = parse_int(parts[1])?
        
        Ok({ a, b }) // record name can be omitted when it's obvious from context
    }
}

enum Operation {
    Add
    Sub
}

impl Operation {
    let new = (input: string) <> Result[Self, SelectCallError] {
        match input.trim() {
            "add" -> Ok(Self::Add)
            "sub" -> Ok(Self::Sub)
            other -> Err(SelectCallError::UnknownOperation(other))
        }
    }

    let perform = (self, in: Inputs) <> int {
        match self {
            Operation::Add -> in.a + in.b
            Operation::Sub -> in.a - in.b
        }
    }
}

// Pure application logic
let app = (input: string, operation_input: string) <> Result[int, SelectCallError] {
    val inputs = Inputs::new(input)?
    val op = Operation::new(operation_input)?
    op.perform(inputs)
}

// Main function to run the application
let main = () <$stdio> { // equivalent to `<$stdin, $stdout, $stderr>`, a shortcut for full access to standard input/output/error
    val input = readln("Enter two numbers separated by a space: ")
    val operation_input = readln("Choose an operation (add/sub): ")
    match app(input, operation_input) {
        Ok(n) -> println("Result: {{n}}")
        Err(e) -> eprintln("Error: {{e}}")
    }
}
