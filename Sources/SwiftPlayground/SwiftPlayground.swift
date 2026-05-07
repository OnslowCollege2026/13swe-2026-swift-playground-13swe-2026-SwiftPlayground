import Foundation

/// School Library Book Borrowing System

/// Create a struct that represents the framework for the books in our library
struct Book: Identifiable, CustomStringConvertible {
    let id: Int
    let name: String
    let author: String
    var availability: Bool

    /// Using CustomStringConvertible, we give a description to make it easier to print out books and their status
    var description: String {
        /// If the books available, print it with 'available' at the end, otherwise print it as 'unavailable'
        if availability == true {
            return "id: \(id), '\(name)' by \(author) (available)"
        } else {
            return "id: \(id), '\(name)' by \(author) (unavailable)"
        }
    }
}
/// Create a struct that represents the users
struct User: Identifiable {
    let id: Int
    let fName: String
    let lName: String
}
/// Create a struct that represents the loans
struct Loan {
    let bookID: Int
    let userID: Int
    var returned: Bool
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
            /// Set our values to nothing
            var name = ""
            var author = ""
            var valid = false

            /// While loop for the BOOK'S name from the user
            while valid == false {
                print("Enter the name of the book you would like to add:")
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
                print("Enter the name of the author of the book:")
                /// Until the user gives us a valid input, keep asking
                if let authorName = readLine() {
                    if authorName != "" {
                        author = authorName
                        valid = true
                    } else {
                        print("Please enter a valid author name.")
                    }
                }
            }
            /// Adds the new book to the available library
            print("Added \(name) by \(author) to the available library.")
            let addedBook = Book(id: nextBookId, name: name, author: author, availability: true)
            books.append(addedBook)

            /// Increase the next book id for the next added book
            nextBookId += 1
        }

        /// Because our user storage already contains 3 users, the next ID given will be '4'
        var nextUserId: Int = 4

        /// Create a func that will act as the code for registering users to the libaray
        func registerUser() {
            /// Set our values to nothing
            var firstName = ""
            var lastName = ""
            var valid: Bool = false
            /// While loop for the user's FIRST name
            while valid == false {
                print("Enter your first name:")
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
                print("Enter your last name:")
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
            /// Adds the new user to the system
            print("Added \(firstName) \(lastName) to the user registration list.")
            let addedUser = User(id: nextUserId, fName: firstName, lName: lastName)
            users.append(addedUser)
            nextUserId += 1
        }
        /// Create a func for issuing books from the available library
        func issueBook() {
            /// Set our values to nothing
            var bookID = 0
            var userID = 0
            var valid = false

            /// While loop for the book ID
            while valid == false {
                print("Enter the ID of the book you would like to issue:")

                /// If the user input isn't a number or is a number that equals 0 (or below 0), ask again
                if let input = readLine(), let id = Int(input) {
                    if id != 0 {
                        bookID = id
                        valid = true
                    } else {
                        print("Please enter a valid ID (number)")
                    }
                } else {
                    print("Please enter a valid ID (number)")
                }
            }

            /// Create the index number for the book search (and make it 0)
            var bookIndex = 0
            /// Make a bool variable to see if the inputted ID is actually present
            var bookFound = false

            /// Loop over every book until the corresponding value is found, or until all books have been looped through
            for book in books {
                if book.id == bookID {
                    bookFound = true
                } else {
                    if bookFound == false {
                        bookIndex += 1
                    }
                }
            }
            /// If the book isn't found, exit the loop as tell the user that it wasn't found
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
                print("Enter your user ID:")

                if let input = readLine(), let id = Int(input) {
                    if id != 0 {
                        userID = id
                        valid = true
                    } else {
                        print("Please enter a valid number.")
                    }
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

            let newLoan = Loan(bookID: bookID, userID: userID, returned: false)
            loans.append(newLoan)

            print("Book has been issued successfully.")
        }

        func returnBook() {
            var bookID: Int = 0
            var bookFound: Bool = false
            var bookIndex: Int = 0

            while bookFound == false {

                print("Enter the ID of the book you would like to return:")
                if let input = readLine(), let id = Int(input) {
                    if id != 0 {
                        bookID = id
                        bookFound = false
                        bookIndex = 0

                        for book in books {
                            if book.id == bookID {
                                bookFound = true
                            } else {
                                if bookFound == false {
                                    bookIndex += 1
                                }
                            }
                        }
                        if bookFound == false {
                            print("Book ID not found.")
                        }

                    } else {
                        print("Please enter a valid ID (number)")
                    }
                } else {
                    print("Please enter a valid ID (number)")

                }
            }
            if books[bookIndex].availability == true {
                print("This book is already in the library.")
            } else {

                var loanIndex: Int = 0
                var loanFound: Bool = false

                for loan in loans {
                    if loan.bookID == bookID {
                        loanFound = true
                        break
                    } else {
                        loanIndex += 1
                    }
                }
                if loanFound == true {
                    loans[loanIndex].returned = true
                }
                /// Change the status of the book's availability
                books[bookIndex].availability = true
                print("Book successfully returned.")
            }
        }

        /// Create a func for viewing all available and unavailable books
        func viewAvailableBooks() {
            print("Available books:")
            for book in books {
                if book.availability == true {
                    print(book)
                }

            }
            print("\nUnavailable books:")
            for book in books {
                if book.availability == false {
                    print(book)
                }

            }
        }

        func searchBooks() {
            var menuValid = false
            while menuValid == false {
                print("What would you like to search for: ")
                print(
                    """
                    A. Book name
                    B. Author name
                    """)

                if var menuInput = readLine() {
                    menuInput = menuInput.uppercased().filter { !$0.isWhitespace }

                    if menuInput == "A" {
                        print("Enter the name of the book you are searching for:")

                        menuValid = true
                        var valid = false
                        while valid == false {
                            if let input = readLine() {
                                if input != "" {

                                    valid = true
                                    var found = false

                                    for book in books {
                                        if book.name.lowercased().contains(input.lowercased()) {
                                            print(book)
                                            found = true
                                        }
                                    }
                                    if found == false {
                                        print("Book not found.")
                                    }
                                } else {
                                    print("Please enter a valid book name.")
                                    print("Enter the name of the book you are searching for:")
                                }
                            } else {
                                print("Please enter a valid book name.")
                                print("Enter the name of the book you are searching for:")
                            }
                        }
                    } else if menuInput == "B" {
                        print("Enter the name of the author you are searching for:")

                        menuValid = true
                        var valid = false
                        while valid == false {
                            if let input = readLine() {
                                if input != "" {

                                    valid = true
                                    var found = false

                                    for book in books {
                                        if book.author.lowercased().contains(input.lowercased()) {
                                            print(book)
                                            found = true
                                        }
                                    }
                                    if found == false {
                                        print("Author not found.")
                                    }
                                } else {
                                    print("Please enter a valid book name.")
                                    print("Enter the name of the author you are searching for:")
                                }
                            } else {
                                print("Please enter a valid book name.")
                                print("Enter the name of the author you are searching for:")
                            }
                        }
                    } else {
                        print("Please enter A or B.")
                    }
                }
            }

        }

        func searchUser() {
            var valid = false
            while valid == false {
            print("Enter the first name of the user you are searching for:")
                if let input = readLine() {
                    if input != "" {

                        valid = true
                        var found = false

                        for user in users {
                            if user.fName.lowercased().contains(input.lowercased()) {
                                print(user)
                                found = true
                            }
                        }
                        if found == false {
                            print("User not found.")
                        }
                    } else {
                        print("Please enter a valid first name.")
                    }
                } else {
                    print("Please enter a valid first name.")
                }
            }
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
                F. Search books (title/author)
                G. Search users
                H. Edit records
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
                } else if userInput == "D" {
                    returnBook()
                } else if userInput == "E" {
                    viewAvailableBooks()
                } else if userInput == "F" {
                    searchBooks()
                } else if userInput == "G" {
                    searchUser()
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
