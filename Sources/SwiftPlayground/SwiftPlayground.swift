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
        var lunchTotal = 0.0
        //let weekDays = ["monday", "tuesday", "wesnday", "thursday", "friday"]
        var counter = 1
        var high = 0.0
        for day in lunches{
            lunchTotal += day
            print("day \(counter): $\(day)")
            counter += 1
            if day > high{
                high = day
            }
            if day >= 9{
                print("High spending day detected")
            }
        }
        var snack_total = 0.0
        let snack_cost = 2.5
        while (snack_total < 10){
            snack_total += snack_cost
            print("Snack total: $\(snack_total)")
        }

                print("Lunch total: $\(lunchTotal)")
        print("Snack total: $\(snack_total)")
        print("Combined total: $\(snack_total+lunchTotal)")
        print("Average lunch cost: $\(lunchTotal/5)")
        if (budgetCheck(totalCost: totalCost(lunches:lunches), budget: budget)) {
            print("you stayed in budget")
        }
        else{
            print("Warning: You overspent this week")
        }
        print("Most expensive lunch: \(high)")


    }
}
