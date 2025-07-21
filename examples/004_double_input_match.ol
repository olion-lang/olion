let main = () <$stdin, $stdout> {
    val input = readln("Enter a number: ")
    val message = match int::parse(input) {
        Ok(n) -> "The double of {{n}} is {{n * 2}}!"
        Err(e) -> "Error: {{e}}"
    }
    println(message)
}
