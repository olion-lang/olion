let main = () <$stdin, $stdout> {
    val input = readln("Enter a number: ")
    val number = int::parse(input).unwrap()
    val double = number * 2
    println("The double of {{number}} is {{double}}!")
}
