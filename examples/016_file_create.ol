import std::fs::{create_file, write_file}

let app = (
    path: string,
    initial_content: string,
) <$fscreate, $fswrite> Result[(), string] {
    create_file(path)?
    write_file(path, initial_content)?
}

let main = () <$stdin, $fscreate, $fswrite, $stdout> {
    val file_path = readln("Enter the path to the file: ")
    val initial_content = readln("Enter the initial content for the file: ")
    match app(file_path, initial_content) {
        Ok(_) -> println("File created and written successfully!")
        Err(e) -> println("Error: {{e}}")
    }
}
