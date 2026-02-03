// The Swift Programming Language
// https://docs.swift.org/swift-book
func totalCost(lunches:[Double]) -> Double{
    var cost = 0.0
        for day in lunches{
            cost += day
        }
    return cost
}

func budgetCheck(totalCost: Double, budget: Double) -> Bool {
    if totalCost > budget {
        return false
    } else{
        return true
    }
}
@main

struct SwiftPlayground {
    static func main() {
        let budget = 35.0
        let lunches = [6.50, 8.00, 5.75, 9.20, 7.10]
        //let weekDays = ["monday", "tuesday", "wesnday", "thursday", "friday"]
        var counter = 1
        for day in lunches{
            print("day \(counter): \(day)$")
            counter += 1
        }
        print(totalCost)
        if (budgetCheck) {
            print("you stayed in budget")
        }
    }
}
