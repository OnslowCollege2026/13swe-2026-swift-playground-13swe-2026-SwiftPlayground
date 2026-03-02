// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
struct Student: Identifiable{
    let id: UUID = UUID()
    var name: String
    var age: Int
}
struct Course: CustomStringConvertible{
    let id: UUID = UUID()
    var title: String
    var courseDescription: String
    var description: String {
"\(id) \(title) \(courseDescription)"

}
}
struct Enrolment: Codable{
    let studentId: UUID
    let courseId: UUID

}
@main

struct SwiftPlayground {
    static func main() {
let leb = Student(name: "Leb", age: 14)
let corse1 = Course(title: "how to use after effects, for dumbies", courseDescription: "are you a little node based idot, well then hi leb")
let studentOne = Enrolment(studentId: leb.id, courseId: corse1.id)
//let data = try JSONEncoder().encode(lesson)
}
}