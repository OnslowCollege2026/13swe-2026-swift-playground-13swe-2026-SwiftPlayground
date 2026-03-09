// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
struct Student: Identifiable{
    let id: UUID = UUID()
    var name: String
    var age: Int
}
struct Course: CustomStringConvertible{
    let id: String
    var title: String
    var courseDescription: String
    var description: String {
"\(id) \(title) \(courseDescription)"

}
}
struct Enrolment: Hashable{
    let studentId: UUID
    let courseId: String

}
struct ScoreEntry: Comparable{
    let studentId: UUID
    var points: Int
    static func < (lhs: ScoreEntry, rhs:
    ScoreEntry) -> Bool { lhs.points < rhs.points
    }
}
@main

struct SwiftPlayground {
    static func main() {
let leb = Student(name: "Leb", age: 16)
let millie = Student(name: "Millie", age: 17)
let vfx = Course(id: "lm" ,title: "how to use after effects, for dumbies", courseDescription: "are you a little node based idot, well then hi leb")
let scoreEntrys = [ScoreEntry(studentId: leb.id, points: 0), ScoreEntry(studentId: millie.id, points: 200)]

let studentOne = Enrolment(studentId: leb.id, courseId: vfx.id)

///let data = try! JSONEncoder().encode(studentOne)
///let decoded = try! JSONDecoder().decode(Enrolment.self, from: data)
///print(decoded)
print(scoreEntrys.sorted(by: >))
}
}