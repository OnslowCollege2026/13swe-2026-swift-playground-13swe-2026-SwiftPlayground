import Foundation

/// School Library Book Borrowing System

struct book: Identifiable {
let id: Int
let name: String
let genre: String
let author: String
}
@main
    struct SwiftPlayground {
    static func main() { 
    let bookList = book(id: 1, name: "book1", genre: "Sci-fi", author: "Bob Jobs")
}
}

