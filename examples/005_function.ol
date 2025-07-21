// `<>`, an *empty effect list*, implies this function is **pure**,
// e.g. causing no side effects.
let get_message = (input: string) <> string {
    match int::parse(input) {
        Ok(n) -> "The double of {{n}} is {{n * 2}}!"
        Err(e) -> "Error: {{e}}"
    }
}

let main() <$stdin, $stdout> {
    // side effect
    val input = readln("Enter a number: ")
    
    // pure logic
    val message = get_message(input)
    
    // side effect
    println(message)
}
