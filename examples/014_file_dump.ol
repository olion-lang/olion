import std::fs::read_file

let main = () <$stdin, $fsread, $stdout> {
    val file_path = readln("Enter the path to the file: ")
    match read_file[string](file_path) {
        Ok(content) -> println("File content:\n{{content}}")
        Err(e) -> println("Can't read file: {{e}}")
    }
}
