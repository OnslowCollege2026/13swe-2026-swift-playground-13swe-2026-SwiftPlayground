// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import GRDB

/// a reservation at the cafe.
struct Purchaser : Identifiable, Codable, FetchableRecord, PersistableRecord {

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
struct Order : Identifiable, Codable, FetchableRecord, PersistableRecord {
    let id: Int
    let purchaserId: Int
    var amount: Int

    enum CodingKeys: String, CodingKey {
        case id = "OrderID"
        case purchaserId = "PurchaserID"
        case amount = "Amount"
    }
    }


@main
struct SwiftPlayground {
    static func main() {
        let dbPath = "Sources/SwiftPlayground/cafe.db"
        do {
        let dbQueue = try DatabaseQueue(path: dbPath)
        print("Database connection successful")

        try dbQueue.read { database in
            try database.dumpSchema()

            let windowSitter = try Purchaser.find(database, key: [
                "ReservedTable": "Window Seat"
            ])
            print(windowSitter)
            }
        } catch {
            print(error)
        }
    }
}
