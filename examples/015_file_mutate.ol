import std::fs::write_file

let main = () <$stdin, $fswrite, $stdout> {
    val file_path = readln("Enter the path to the file: ")
    val content = readln("Enter the content to write to the file: ")
    match write_file(file_path, content, { append: true }) {
        Ok(_) -> println("File written successfully!")
        Err(e) -> println("Can't write to file: {{e}}")
    }
}
