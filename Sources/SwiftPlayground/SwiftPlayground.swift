// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import GRDB

/// a reservation at the cafe.
struct Purchaser: Identifiable, Codable, FetchableRecord, PersistableRecord {

    /// the purchaser Id.
    let id: Int

    /// the name of the purchaser.
    var name: String

    /// the amount of people in the purchasers party.
    var count: Int

    /// the name of the reserved table.
    var reservedTable: String

    enum CodingKeys: String, CodingKey {
        case id = "PurchaserID"
        case name = "Name"
        case count = "Count"
        case reservedTable = "ReservedTable"
    }
}
struct Order: Identifiable, Codable, FetchableRecord, PersistableRecord {
    /// The order Id
    let id: Int
    /// The Id for the purchaser
    let purchaserId: Int
    /// The amount of items recorded.
    var amount: Int

    enum CodingKeys: String, CodingKey {
        case id = "OrderID"
        case purchaserId = "PurchaserID"
        case amount = "Amount"
    }
}
struct Item: Identifiable, Codable, FetchableRecord, PersistableRecord {

    /// The ID for the item.
    let id: Int
    /// The name of the item.
    var name: String
    /// The price on the desired item.
    var price: String

    enum CodingKeys: String, CodingKey {
        case id = "ItemID"
        case name = "Name"
        case price = "Price"
    }
}
struct OrderLine: Identifiable, Codable, FetchableRecord, PersistableRecord {
    /// The order line Id.
    let id: Int
    /// The order Id for the order line.
    let orderId: Int
    /// The item Id for the order line.
    let itemId: Int
    /// The quantity of the item ordered.
    var quantity: Int

    enum CodingKeys: String, CodingKey {
        case id = "OrderLineID"
        case orderId = "OrderID"
        case itemId = "ItemID"
        case quantity = "Quantity"
    }
}

@main
struct SwiftPlayground {
    static func main() {
        let dbPath = "Sources/SwiftPlayground/cafe.db"
        do {
            let dbQueue = try DatabaseQueue(path: dbPath)
            print("Database connection successful")

            try dbQueue.read({ db in
                try db.dumpSchema()
            })

            let purchaserID = 5

            try dbQueue.read({ db in
                let purchaser = try Purchaser.fetchOne(db, key: purchaserID)
                if let purchaser {
                    print("Found purchaser with ID \(purchaserID): \(purchaser.name)")
                } else {
                    print("No purchaser found with ID \(purchaserID)")
                }
            })

        } catch {
            print(error)
        }
    }
}
