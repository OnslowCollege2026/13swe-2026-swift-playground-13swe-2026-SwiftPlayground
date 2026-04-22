// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct SwiftPlayground {
    static func main() {
        /// Task 1
        let list: [Int] = [3, 7, 8, 18]
        let total = list.reduce(0){$0 + $1}
        print(total)
        /// Task 2
        let oddNumber = list.filter {$0 % 2 != 0}
        print(oddNumber)
        /// Task 3
        let highestValue = list.reduce(0){Swift.max($1 , $0)}
        print(highestValue)
        /// Task 4
        let belowFifteen = list.filter {$0 < 15}
        print(belowFifteen)
        /// Task 5
        let roundedTen = list.map {($0 + 9) / 10 * 10}
        print(roundedTen)
    }
}