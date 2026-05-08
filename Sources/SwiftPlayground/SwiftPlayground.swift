import Foundation

/// School Library Book Borrowing System

/// Create a struct that represents the framework for the books in our library
struct Book: Identifiable, CustomStringConvertible {
    let id: Int
    var name: String
    var author: String
    var availability: Bool

    /// Using CustomStringConvertible, we give a description to make it easier to print out books and their status
    var description: String {
        /// If the books available, print it with 'available' at the end, otherwise print it as 'unavailable'
        if availability == true {
            return "ID: \(id) | '\(name)' by \(author) (available)"
        } else {
            return "ID: \(id) | '\(name)' by \(author) (unavailable)"
        }
    }
}
/// Create a struct that represents the users
struct User: Identifiable, CustomStringConvertible {
    let id: Int
    var fName: String
    var lName: String

    var description: String {
        return "ID: \(id) | '\(fName) \(lName)'"
    }
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
            var name: String = ""
            var author: String = ""
            var valid: Bool = false

            /// While loop for the BOOK'S name from the user
            while valid == false {
                print("Enter the name of the book you would like to add:")
                /// Until the user gives us a valid input, keep asking
                if let bookName = readLine() {
                    if bookName == "" {
                        print("Please enter a valid book name.")

                    } else if bookName.count > 80 {
                        print("Book name cannot exceed 80 characters.")
                        print("That book title is \(bookName.count) characters long")
                    } else {
                        name = bookName
                        valid = true
                    }
                }
            }
            valid = false

            /// While loop for the AUTHOR'S name from the user
            while valid == false {
                print("Enter the name of the author of the book:")
                /// Until the user gives us a valid input, keep asking
                if let authorName = readLine() {
                    if authorName == "" {
                        print("Please enter a valid author name.")
                    } else if authorName.count > 50 {
                        print("Author name cannot exceed 50 characters.")
                        print("That author name is \(authorName.count) characters long")

                    } else {
                        author = authorName
                        valid = true
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
                    if userFirstName == "" {
                        print("Please enter a valid first name.")

                    /// If the first name exceeds 30 characters, don't accept it
                    } else if userFirstName.count > 30 {
                        print("First name cannot exceed 30 characters")
                        print("That first name is \(userFirstName.count) characters long")
                    } else {
                        firstName = userFirstName
                        valid = true
                    }
                }
            }
            valid = false

            /// While loop for the user's LAST name
            while valid == false {
                print("Enter your last name:")
                /// Until the user gives us a valid input, keep asking
                if let userLastName = readLine() {
                    if userLastName == "" {
                        print("Please enter a valid last name.")
                    /// If the last name exceeds 30 characters, don't accept it
                    } else if userLastName.count > 30 {
                        print("Last name cannot exceed 30 characters")
                        print("That first name is \(userLastName.count) characters long")
                    } else {
                        lastName = userLastName
                        valid = true
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
            var bookIndex: Int = 0
            /// Make a bool variable to see if the inputted ID is actually present
            var bookFound: Bool = false

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

            /// If the book is found, yet the availability is false, tell the user they are unable to issue it
            if books[bookIndex].availability == false {
                print("This book is currently unavailable.")
                return
            }
            valid = false

            /// While loop asking for a valid ID
            while valid == false {
                print("Enter your user ID:")

                /// If the user input isn't a number or is a number that equals 0 (or below 0), ask again
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


            /// Loop through all users until the correct one is found
            for user in users {
                if user.id == userID {
                    userFound = true
                }
            }
            /// If the user isn't found, tell the user
            if userFound == false {
                print("User not found.")
                return
            }


            /// Change the book's availability to false
            books[bookIndex].availability = false

            /// Record the loan
            let newLoan = Loan(bookID: bookID, userID: userID, returned: false)
            loans.append(newLoan)

            print("Book has been issued successfully.")
        }

        /// Create a func for returning books
        func returnBook() {
            var bookID: Int = 0
            var bookFound: Bool = false
            var bookIndex: Int = 0

            /// While the book is not found, loop over this code
            while bookFound == false {
                
                /// If the user input isn't a number or is a number that equals 0 (or below 0), ask again
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
            /// If the book's availability is true, then tell the user it is already in the library
            if books[bookIndex].availability == true {
                print("This book is already in the library.")
            } else {

                var loanIndex: Int = 0
                var loanFound: Bool = false

                /// Loop through all loans until the correct one is found
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
        func viewBooks() {


            print("\nAvailable books:")
            /// Filter all the available books in one constant
            let availableBooks = books.filter { $0.availability == true }
            
            /// Use the reduce function to find the direct amount of available books
            let availableCount = books.reduce(0) { count, book in 
            if book.availability == true {
                return count + 1
            } else {
                return count
            }
        }
            // Loop through all available books
            for book in availableBooks {
                print(book)
            }
            /// Print the total amount of available books
            print("Total available books: \(availableCount)")


            print("\nUnavailable books:")
            /// Filter all the unavailable books in one constant
            let unavailableBook = books.filter { $0.availability == false }

            /// Use the reduce function to find the direct amount of UNavailable books
            let unavailableCount = books.reduce(0) { count, book in 
            if book.availability == false {
                return count + 1
            } else {
                return count
            }
        }
            /// Loop through all unavailable books
            for book in unavailableBook {
                print(book)
            }
            /// Print the total amount of unavailable books
            print("Total unavailable books: \(unavailableCount)")
        }

        /// Create a func for searching for books
        func searchBooks() {
            var menuValid = false
            while menuValid == false {
                print("Enter what you would like to search for: ")
                print(
                    """
                    A. Book name
                    B. Author name
                    """)

                if var menuInput = readLine() {
                    menuInput = menuInput.uppercased().filter { !$0.isWhitespace }

                    /// If the user's input is A, loop through the Book Name code
                    if menuInput == "A" {
                        print("Enter the name of the book you are searching for:")

                        menuValid = true
                        var valid: Bool = false
                        while valid == false {
                            if let input = readLine() {
                                if input != "" {

                                    valid = true
                                    var found: Bool = false

                                    /// Loop through and print all books that contain the user's input
                                    for book in books {
                                        if book.name.lowercased().contains(input.lowercased()) {
                                            print(book)
                                            found = true
                                        }
                                    }
                                    /// If nothing is found, tell the user
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
                    /// If the user inputs B, then play the Author Name loop
                    } else if menuInput == "B" {
                        print("Enter the name of the author you are searching for:")

                        menuValid = true
                        var valid: Bool = false
                        while valid == false {
                            if let input = readLine() {
                                if input != "" {

                                    valid = true
                                    var found: Bool = false

                                    /// Loop through and print all books that contain the user's input
                                    for book in books {
                                        if book.author.lowercased().contains(input.lowercased()) {
                                            print(book)
                                            found = true
                                        }
                                    }
                                    /// If nothing is found, tell the user
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

        /// Create a func for searching for users
        func searchUser() {
            var valid: Bool = false
            while valid == false {
                print("Enter the first name of the user you are searching for:")
                if let input = readLine() {
                    if input != "" {

                        valid = true
                        var found: Bool = false

                        /// Loop through and print all users that contain the user's input
                        for user in users {
                            if user.fName.lowercased().contains(input.lowercased()) {
                                print(user)
                                found = true
                            }
                        }
                        /// If nothing is found, tell the user
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

        /// Create a func for editing records
        func editRecord() {
            var menuValid: Bool = false
            while menuValid == false {
                print("Enter what record would you like to edit:")
                print(
                    """
                    A. Book record
                    B. User record
                    """)

                if var menuInput = readLine() {
                    menuInput = menuInput.uppercased().filter { !$0.isWhitespace }

                    /// If the inputs A, run the Book record code
                    if menuInput == "A" {
                        var bookID: Int = 0
                        var bookIndex: Int = 0
                        var bookFound: Bool = false

                        /// While loop for until the book the user is searching for is found
                        while bookFound == false {
                            print("Enter the ID of the book you would like to edit:")

                            /// If the user input isn't a number or is a number that equals 0 (or below 0), ask again
                            if let input = readLine(), let id = Int(input) {
                                bookID = id

                                /// Loop through all book IDs until the user's input is found
                                for book in books {
                                    if book.id == bookID {
                                        bookFound = true
                                        break
                                    } else {
                                        bookIndex += 1
                                    }
                                }

                                /// If nothing is found, tell the user
                                if bookFound == false {
                                    print("Book ID not found.")
                                    return
                                }
                            } else {
                                print("Please enter a valid number.")
                            }
                        }

                        /// If the book ID is found, ask the user for the new Book name
                        var newBookName: String = ""
                        var bookValid: Bool = false

                        while bookValid == false {
                            print("Enter new book name:")

                            if let input = readLine() {
                                if input == "" {
                                    print("Please enter a valid input")
                                /// If the user's character amount exceeds 80, tell the user that it's too long
                                } else if input.count > 80 {
                                    print("Book name cannot exceed 80 characters.")
                                    print("That book title is \(input.count) characters long")
                                } else {
                                    newBookName = input
                                    bookValid = true
                                }
                            } else {
                                print("Please enter a valid input")
                            }
                        }
                        /// Ask the user for the new Author name
                        var newAuthorName: String = ""
                        var authorValid: Bool = false

                        while authorValid == false {
                            print("Enter new author name:")

                            if let input = readLine() {
                                if input == "" {
                                    print("Please enter a valid input")
                                /// If the user's character amount exceeds 40, tell the user that it's too long
                                } else if input.count > 40 {
                                    print("Author name cannot exceed 40 characters.")
                                    print(
                                        "That author name is \(input.count) characters long"
                                    )
                                } else {
                                    newAuthorName = input
                                    authorValid = true
                                }
                            } else {
                                print("Please enter a valid input")
                            }
                        }
                        /// Add both the new book name and author name to the corresponding book record
                        books[bookIndex].name = newBookName
                        books[bookIndex].author = newAuthorName

                        print("Book and author name updated successfully.")
                        menuValid = true

                    /// Else if they decide to change a user record (instead of a book record)
                    } else if menuInput == "B" {
                        var userID: Int = 0
                        var userIndex: Int = 0
                        var userFound: Bool = false

                        while userFound == false {
                            print("Enter the ID of the user you would like to edit:")

                            if let input = readLine(), let id = Int(input) {
                                userID = id

                                /// Loop through all user IDs until the user's input is found
                                for user in users {
                                    if user.id == userID {
                                        userFound = true
                                        break
                                    } else {
                                        userIndex += 1
                                    }
                                }

                                /// If not found, tell the user
                                if userFound == false {
                                    print("User ID not found.")
                                    return
                                }
                            } else {
                                print("Please enter a valid number.")
                            }
                        }
                        /// Ask the user for the new first name of the user record
                        var newFirstName: String = ""
                        var firstValid: Bool = false

                        while firstValid == false {
                            print("Enter new first name:")

                            if let input = readLine() {
                                if input == "" {
                                    print("Please enter a valid input")
                                /// If the user's character amount exceeds 30, tell the user that it's too long
                                } else if input.count > 30 {
                                    print("First name cannot exceed 30 characters.")
                                    print("That first name is \(input.count) characters long")
                                } else {
                                    newFirstName = input
                                    firstValid = true
                                }
                            } else {
                                print("Please enter a valid input")
                            }
                        }
                        /// Ask the user for the new last name of the user record
                        var newLastName: String = ""
                        var lastValid: Bool = false

                        while lastValid == false {
                            print("Enter new last name:")

                            if let input = readLine() {
                                if input == "" {
                                    print("Please enter a valid input")
                                /// If the user's character amount exceeds 30, tell the user that it's too long
                                } else if input.count > 30 {
                                    print("Last name cannot exceed 30 characters.")
                                    print(
                                        "That last name is \(input.count) characters long"
                                    )
                                } else {
                                    newLastName = input
                                    lastValid = true
                                }
                            } else {
                                print("Please enter a valid input")
                            }
                        }
                        /// Add both the new first name and last name to the corresponding user record
                        users[userIndex].fName = newFirstName
                        users[userIndex].lName = newLastName

                        print("User name updated successfully.")
                        menuValid = true
                    /// Else if the user inputs neither, ask again
                    } else {
                        print("Please enter A or B.")
                    }
                }
            }
        }

        /// Create a func for deleting records
        func deleteRecord() {
            var menuValid: Bool = false
            while menuValid == false {
                print("Enter what record would you like to delete:")
                print(
                    """
                    A. Book record
                    B. User record
                    """)

                if var menuInput = readLine() {
                    menuInput = menuInput.uppercased().filter { !$0.isWhitespace }

                    if menuInput == "A" {
                        var bookID: Int = 0
                        var bookIndex: Int = 0
                        var bookFound: Bool = false

                        while bookFound == false {
                            print("Enter the ID of the book you would like to delete:")

                            if let input = readLine(), let id = Int(input) {
                                bookID = id

                                /// Loop through every book ID until the user's input is found
                                for book in books {
                                    if book.id == bookID {
                                        bookFound = true
                                        break
                                    } else {
                                        bookIndex += 1
                                    }
                                }

                                /// If not found, tell the user
                                if bookFound == false {
                                    print("Book ID not found.")
                                    return
                                }
                            } else {
                                print("Please enter a valid number.")
                            }
                        }

                        /// If found, remove the book record from the system
                        books.remove(at: bookIndex)
                        print("Book has been deleted from the library.")
                        menuValid = true

                    /// Else if the user inputs B, run the user deletion code
                    } else if menuInput == "B" {
                        var userID: Int = 0
                        var userIndex: Int = 0
                        var userFound: Bool = false

                        while userFound == false {
                            print("Enter the ID of the user you would like to delete:")

                            if let input = readLine(), let id = Int(input) {
                                userID = id

                                /// Loop through all user IDs until the user's input is found
                                for user in users {
                                    if user.id == userID {
                                        userFound = true
                                        break
                                    } else {
                                        userIndex += 1
                                    }
                                }

                                /// If not found, tell the user
                                if userFound == false {
                                    print("User ID not found.")
                                    return
                                }
                            } else {
                                print("Please enter a valid number.")
                            }
                        }
                        /// If found, remove the user record from the system
                        users.remove(at: userIndex)
                        print("User has been removed from the system.")
                        menuValid = true
                    /// If the user inputs neither, ask again
                    } else {
                        print("Please enter A or B.")
                    }
                }
            }
        }

        /// Create a menu for the user
        var valid: Bool = true
        while valid == true {
            print(
                """
                \nA. Add new book
                B. Register user
                C. Issue book
                D. Return book
                E. View available/unavailable books
                F. Search books (title/author)
                G. Search users
                H. Edit record
                I. Delete record
                Q. Quit
                """)
            /// If the user inputs any letter, run the corresponding func
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
                    viewBooks()
                } else if userInput == "F" {
                    searchBooks()
                } else if userInput == "G" {
                    searchUser()
                } else if userInput == "H" {
                    editRecord()
                } else if userInput == "I" {
                    deleteRecord()
                /// If the user inputs 'Q', then exit the code
                } else if userInput == "Q" {
                    valid = false
                /// If the user inputs nothing, ask again
                } else {
                    print("Please enter a valid input.")
                }
            }
        }
    }
}
