import Foundation

/// School Library Book Borrowing System

struct Book: Identifiable {
let id: Int
let name: String
let author: String
let availability: Bool

struct user: Identifiable {
let id: Int
let name: String
}

struct loan {
let bookID: Int
let userID: Int
}

}
@main
    struct SwiftPlayground {
    static func main() { 

}
}

