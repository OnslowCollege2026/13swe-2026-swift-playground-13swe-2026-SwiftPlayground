import Foundation

/// School Library Book Borrowing System

/// Create a struct that represents the framework for the books in our library
struct Book: Identifiable {
    let id: Int
    let name: String
    let author: String
    var availability: Bool
}
/// Create a struct that represents the borrowers
struct User: Identifiable {
    let id: Int
    let fName: String
    let lName: String
}
/// Create a struct that represents the loan itself
struct Loan {
    let bookID: Int
    let userID: Int
}

@main
struct SwiftPlayground {
    static func main() {

        /// Create storage for all books in the library
        var books: [Book] = [
            Book(id: 1, name: "Animal Farm", author: "George Orwell", availability: true),
            Book(id: 2, name: "Blood Meridian", author: "Cormac McCarthy", availability: true),
            Book(id: 3, name: "To Kill A Mocking Bird", author: "Harper Lee", availability: true),
        ]

        /// Create storage for all the users apart of the system
        var users: [User] = [
            User(id: 1, fName: "Cameron", lName: "Heron"),
            User(id: 2, fName: "Peter", lName: "Griffin"),
            User(id: 3, fName: "Retep", lName: "Griffin"),
        ]

        /// Create storage for all loans made (starting empty)
        var loans: [Loan] = []

        /// Because our book storage already contains 3 books, the next ID given will be '4'
        var nextBookId: Int = 4

        /// Create a func that will act as the code for adding books to the library
        func addBooks() {
            var name = ""
            var author = ""
            var valid = false

            /// While loop for the BOOK'S name from the user
            while valid == false {
                print("What is the name of the book you would like to add?")
                /// Until the user gives us a valid input, keep asking
                if let bookName = readLine() {
                    if bookName != "" {
                        name = bookName
                        valid = true
                    } else {
                        print("Please enter a valid book name.")
                    }
                }
            }
            valid = false

            /// While loop for the AUTHOR'S name from the user
            while valid == false {
                print("What is the name of the author of the book?")
                /// Until the user gives us a valid input, keep asking
                if let authorName = readLine() {
                    if authorName != "" {
                        author = authorName
                        valid = true
                    } else {
                        print("Please enter a valid author name")
                    }
                }
            }
            print("Added \(name) by \(author) to the available library.")
            let addedBook = Book(id: nextBookId, name: name, author: author, availability: true)
            books.append(addedBook)

            nextBookId += 1
        }

        var nextUserId: Int = 4

        /// Create a func that will act as the code for registering users to the libaray
        func registerUser() {
            var firstName = ""
            var lastName = ""
            var valid: Bool = false
            /// While loop for the user's FIRST name
            while valid == false {
                print("What is your first name?")
                /// Until the user gives us a valid input, keep asking
                if let userFirstName = readLine() {
                    if userFirstName != "" {
                        firstName = userFirstName
                        valid = true
                    } else {
                        print("Please enter a valid first name.")
                    }
                }
            }
            valid = false

            /// While loop for the user's LAST name
            while valid == false {
                print("What is your last name?")
                /// Until the user gives us a valid input, keep asking
                if let userLastName = readLine() {
                    if userLastName != "" {
                        lastName = userLastName
                        valid = true
                    } else {
                        print("Please enter a valid last name.")
                    }
                }
            }
            print("Added \(firstName) \(lastName) to the user registration list.")
            let addedUser = User(id: nextUserId, fName: firstName, lName: lastName)
            users.append(addedUser)
            nextUserId += 1
        }
        /// Create a func for issuing books from the available library
        func issueBook() {
            var bookID = 0
            var userID = 0
            var valid = false

            while valid == false {
                print("Enter the ID of the book you would like to issue.")

                if let input = readLine(), let id = Int(input) {
                    bookID = id
                    valid = true
                } else {
                    print("Please enter a valid number")
                }
            }

            var bookIndex = 0
            /// Make a bool variable to see if the inputted ID is actually present
            var bookFound = false

            for book in books {
                if book.id == bookID {
                    bookFound = true
                    break
                } else {
                    bookIndex += 1
                }
            }
            if bookFound == false {
                print("Book ID not found.")
                return
            }

            if books[bookIndex].availability == false {
                print("This book is currently unavailable.")
                return
            }
            valid = false

            while valid == false {
                print("Please enter your user ID:")

                if let input = readLine(), let id = Int(input) {
                    userID = id
                    valid = true
                } else {
                    print("Please enter a valid number.")
                }
            }

            var userFound: Bool = false

            for user in users {
                if user.id == userID {
                    userFound = true
                }
            }
            if userFound == false {
                print("User not found.")
                return
            }

            books[bookIndex].availability = false

            let newLoan = Loan(bookID: bookID, userID: userID)
            loans.append(newLoan)

            print("Book has been issued successfully.")
        }

        /// Create a menu for the user

        var valid = true
        while valid == true {
            print(
                """
                A. Add new book
                B. Register user
                C. Issue book
                D. Return book
                E. View available books
                F. Search items
                G. Edit records
                Q. Quit
                """)
            if var userInput = readLine() {
                userInput = userInput.uppercased().filter { !$0.isWhitespace }
                if userInput == "A" {
                    addBooks()
                } else if userInput == "B" {
                    registerUser()
                } else if userInput == "C" {
                    issueBook()
                } else if userInput == "Q" {
                    valid = false
                } else {
                    print("Please enter a valid input.")
                }
            }

        }
        for user in users {
            print(user)
        }

        for book in books {
            print(book)
        }
        for loan in loans {
            print(loan)
        }
    }
}
