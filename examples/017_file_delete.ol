import std::fs::delete_file

let main = () <$stdin, $fsdelete, $stdout> {
    val file_path = readln("Enter the path to the file to delete: ")
    match delete_file(file_path) {
        Ok(_) -> println("File deleted successfully!")
        Err(e) -> println("Error deleting file: {{e}}")
    }
}
