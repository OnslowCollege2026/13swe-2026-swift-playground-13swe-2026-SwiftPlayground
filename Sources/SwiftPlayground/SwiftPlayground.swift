import Foundation
import GRDB
struct Borrowers: Identifiable, Codable, FetchableRecord, PersistableRecord, TableRecord {

    let id: Int?
    var givenName: String
    var familyName: String
    var email: String
    var borrowerType: String
    var yearLevel: String?

    func summary() -> String {
        return "Borrower: \(givenName) \(familyName) has the email: \(email) and is a \(borrowerType)"
    }


    enum CodingKeys: String, CodingKey {
        case id = "BorrowerID"
        case givenName = "Given Name"
        case familyName = "Family Name"
        case email = "Email"
        case borrowerType = "Borrower Type"
        case yearLevel = "Year Level"
    }

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let givenName = Column(CodingKeys.givenName)
        static let familyName = Column(CodingKeys.familyName)
        static let email = Column(CodingKeys.email)
        static let borrowerType = Column(CodingKeys.borrowerType)
        static let yearLevel = Column(CodingKeys.yearLevel)
    }
}

struct Loans: Identifiable, Codable, FetchableRecord, PersistableRecord, TableRecord {

    let id: Int?
    var dateOfIssue: String
    var dateOfReturn: String?
    var dueDate: String
    let borrowerID: Int
    let itemID: Int
    
    func summary() -> String {
        return "This item with id: \(itemID) was issued on \(dateOfIssue), is due back: \(dueDate) from borrower: \(borrowerID)"
    }

    enum CodingKeys: String, CodingKey {
        case id = "LoanID"
        case dateOfIssue = "Date of Issue"
        case dateOfReturn = "Date of Return"
        case dueDate = "Due Date"
        case borrowerID = "BorrowerID"
        case itemID = "ItemID"
    }

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let dateOfIssue = Column(CodingKeys.dateOfIssue)
        static let dateOfReturn = Column(CodingKeys.dateOfReturn)
        static let dueDate = Column(CodingKeys.dueDate)
        static let borrowerID = Column(CodingKeys.borrowerID)
        static let itemID = Column(CodingKeys.itemID)
    }
}

struct Items: Identifiable, Codable, FetchableRecord, PersistableRecord, TableRecord {

    let id: Int?
    var itemName: String
    var itemType: String
    var itemCondition: String

    func summary() -> String {
        return "Item: \(itemName) is a \(itemType) and is in \(itemCondition) condition."
    }

    enum CodingKeys: String, CodingKey {
        case id = "ItemID"
        case itemName = "Item Name"
        case itemType = "Item Type"
        case itemCondition = "Item Condition"
    }

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let itemName = Column(CodingKeys.itemName)
        static let itemType = Column(CodingKeys.itemType)
        static let itemCondition = Column(CodingKeys.itemCondition)
    }
}

@main
struct SwiftPlayground {
    static func main() {
        let dbPath = "Sources/SwiftPlayground/Japanese Item tracking.db"
        var dataEntry = true
        var userYearLevel: String? = nil

        var dbQueue: DatabaseQueue

        do {
            dbQueue = try DatabaseQueue(path: dbPath)
            print("database connection succesful")

            repeat {
                dataEntry = true
                print("""
                What action would you like to take next?
                1: Print a list of borrrowers
                2: Print a list of available items
                3: Add a new borrower
                4: Add a new item
                5: Create a loan
                6: Print a list of ongoing loans
                7: End the program
                """)

                guard let userChoice = readLine(), !userChoice.isEmpty else {
                    print("Please enter one of the options")
                    dataEntry = true
                    continue
                }

                if userChoice == "1" {
                    try dbQueue.read { db in
                        let borrowerList = try Borrowers.fetchAll(db)
                        for borrower in borrowerList {
                            print(borrower.summary())
                        }
                    }
                }

                if userChoice == "2" {
                    try dbQueue.read { db in
                        let itemList = try Items.fetchAll(db)
                        for item in itemList {
                            print(item.summary())
                        }
                    }
                }

                if userChoice == "3" {

                    print("What is the first name of the Borrower you are adding?")
                    guard let userBorrowerFirstName = readLine(), !userBorrowerFirstName.isEmpty else {
                        print("First Name is required")
                        dataEntry = true
                        continue
                    }

                    print("What is the last name of the Borrower you are adding?")
                    guard let userBorrowerLastName = readLine(), !userBorrowerLastName.isEmpty else {
                        print("Last name is required")
                        dataEntry = true
                        continue
                    }

                    print("What is the email address of the Borrower you are adding?")
                    guard let userBorrowerEmail = readLine(), !userBorrowerEmail.isEmpty else {
                        print("Email is required")
                        dataEntry = true
                        continue
                    }

                    print("Is the borrower a Student or a Staff? Enter 1, if they are a Student, enter 2, if they are Staff.")
                    guard let userBorrowerTypeInput = readLine(), !userBorrowerTypeInput.isEmpty else {
                        print("Borrower type is required")
                        dataEntry = true
                        continue
                    }

                    if userBorrowerTypeInput == "1" {
                    var userBorrowerType = "Student"
                        print("What is the year level of the Student? Year level should be between 9 and 13")
                        guard var userYearLevel = readLine(), ["9", "10", "11", "12", "13"].contains(userYearLevel) else {
                            print("Year level should be a number between 9 and 13")
                            dataEntry = true
                            continue
                        }
                        try dbQueue.write { db in
                            var newBorrower = Borrowers(id: nil, givenName: userBorrowerFirstName, familyName: userBorrowerLastName, email: userBorrowerEmail,   borrowerType: userBorrowerType, yearLevel: userYearLevel)
                            try newBorrower.insert(db)
                        }

                    } else if userBorrowerTypeInput == "2" {
                        userYearLevel = nil
                        var userBorrowerType = "Staff"
                        try dbQueue.write { db in
                            var newBorrower = Borrowers(id: nil, givenName: userBorrowerFirstName, familyName: userBorrowerLastName, email: userBorrowerEmail,   borrowerType: userBorrowerType, yearLevel: userYearLevel)
                            try newBorrower.insert(db)
                        }

                    } else {
                        dataEntry = true
                    }
                }

                if userChoice == "4" {
                    print("What is the name of the Item you are adding?")
                    guard let userItemName = readLine(), !userItemName.isEmpty else {
                        print("Item Name is required")
                        dataEntry = true
                        continue
                    }

                    print("What is the type of item you are adding? eg: book, movie, textbook")
                    guard let userItemType = readLine(), !userItemType.isEmpty else {
                        print("Item Type is required")
                        dataEntry = true
                        continue
                    }

                    print("What is the condition of the item you are adding? eg: good, fair, bad")
                    guard let userItemCondition = readLine(), !userItemCondition.isEmpty else {
                        print("Item condition is required")
                        dataEntry = true
                        continue
                    }

                    try dbQueue.write { db in
                            let newItem = Items(id: nil, itemName: userItemName, itemType: userItemType, itemCondition: userItemCondition)
                            try newItem.insert(db)
                    }
                }

                if userChoice == "5" {
                    print("What is the date of issue? Date format should be YYYY/MM/DD")
                    guard let userIssueDate = readLine(), !userIssueDate.isEmpty else {
                        print("Date of Issue is required")
                        dataEntry = true
                        continue
                    }

                    print("""
                        What is the date of return of the Item?
                        date format is the same as the date of issue

                        If the item hasn't been returned yet, enter a null input
                        """)
                    let userReturnDate = readLine()

                    print("What is the due date of the item? date format is still: YYYY/MM/DD")
                    guard let userDueDate = readLine(), !userDueDate.isEmpty else {
                        print("Due Date is required")
                        dataEntry = true
                        continue
                    }

                    var borrowerIDList: [Int] = []
                    var itemIDList: [Int] = []

                    
                    
                    try dbQueue.write { db in
                        let borrowerList = try Borrowers.fetchAll(db)
                        for borrower in borrowerList {
                            print(borrower)
                        }

                        let borrowerIDList = try Int.fetchAll(db, sql: "SELECT BorrowerID FROM Borrowers")

                        let itemIDList = try Int.fetchAll(db, sql: "SELECT ItemID FROM Items")
                    
                        print("""
                        For the above list of borrowers, which person is borrowing the item? 
                        Enter the id number of the borrower
                        """)

                        guard let userBorrowerIDInput = readLine(), !userBorrowerIDInput.isEmpty else {
                            dataEntry = true
                            return print("BorrowerID is required")
                        }

                        guard let userBorrowerIDNum = Int(userBorrowerIDInput), borrowerIDList.contains(userBorrowerIDNum) else {
                            dataEntry = true
                            return print("Please enter a number corresponding to a borrower ID")
                            
                        }

                        let itemList = try Items.fetchAll(db)
                        for item in itemList {
                            print(item)
                        }

                        print("""
                        For the above list of items, which item would the borrower like to borrow?
                        Enter the ID number of the item requested
                        """)

                        guard let userItemIDInput = readLine(), !userItemIDInput.isEmpty else {
                            dataEntry = true
                            return print("ItemID is required")
                        }

                        guard let userItemIDNum = Int(userItemIDInput), itemIDList.contains(userItemIDNum) else {
                            dataEntry = true
                            return print("Please enter a number corresponding to an item ID")
                            
                        }
                        
                        
                        let newLoan = Loans(id: nil, dateOfIssue: userIssueDate, dateOfReturn: userReturnDate, dueDate: userDueDate, borrowerID: userBorrowerIDNum, itemID: userItemIDNum)
                        try newLoan.insert(db)
                        
                    }
                }


                if userChoice == "6" {
                    try dbQueue.read { db in
                        var loanList = try Loans.fetchAll(db)
                        for loan in loanList {
                            if loan.dateOfReturn == nil {
                                print(loan.summary())
                            }
                        }
                    }
                }

                if userChoice == "7" {
                    print("Thanks for using the Japanese Item Tracking Database")
                    break
                }

                else {
                    print("Please enter one of the options")
                    dataEntry = true
                }
            } while dataEntry == true
        } catch{
            print("There was an error: \(error)")
            exit(1)
        }
    } 
}

