let add = (a: int, b: int) <> int {
    a + b
}

let sub = (a: int, b: int) <> int {
    a - b
}

let main = () <$stdin, $stdout> {
    val input = readln("Enter two numbers separated by a space: ")
    val parts = input.trim().split(" ")
    
    if parts.len() != 2 {
        println("Error: Please enter exactly two numbers.")
        return
    }
    
    val a = int::parse(parts[0]) {
        Ok(n) -> n
        Err(e) -> {
            println("Error: Invalid number '{{parts[0]}}': {{e}}")
            return
        }
    }
    val b = int::parse(parts[1]) {
        Ok(n) -> n
        Err(e) -> {
            println("Error: Invalid number '{{parts[1]}}': {{e}}")
            return
        }
    }
    
    val operation = readln("Choose an operation (add/sub): ")
    
    val result = match operation.trim() {
        "add" -> add(a, b)
        "sub" -> sub(a, b)
        other -> {
            println("Error: Unknown operation: {{other}}")
            return
        }
    }
    
    println("Result: {{result}}")
    Ok(())
}
