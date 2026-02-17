// The Swift Programming Language
// https://docs.swift.org/swift-book

@main

struct SwiftPlayground {
    static func main() {
func accepts(input: String, isValid: (String) -> Bool) -> Bool {
    return isValid(input)
}

let sample = "moonlight"
func valid (_ text: String)-> Bool{
    return text.allSatisfy{ String($0) == String($0.lowercased())}

}
print(accepts(input: sample, isValid: valid))



        let sightings = [
    (name: "moth", score: 3),
    (name: "wolf", score: 9),
    (name: "raven", score: 4),
    (name: "mist", score: 7),
    (name: "wisp", score: 2)
]
    let M_Ws = sightings.filter { seen in return (seen.name).first == "m" || (seen.name).first == "w"}
    let Jscores = M_Ws.map{M_W in return (M_W.score)}
    let result = Jscores.reduce(0) { result, jscore in
    return result + jscore
    }
    let maxValue = Jscores.max { $0 < $1}
    let minValue = Jscores.min { $0 < $1}
    print (minValue, maxValue, result, M_Ws)




        let mixed = ["cat", "7", "owl", "15", "dog", "3"]
        let pure = mixed.compactMap { Int($0) }
        let impure = mixed.allSatisfy { $0 is String}
        print(pure)
        print(impure)

        let archive = [
    [
        [["candle", "dust"], ["mirror", "ash"]],
        [["whisper", "shadow"], ["clock", "veil"]]
    ],
    [
        [["stone", "key"], ["relic", "name"]],
        [["cipher", "bone"], ["ember", "seal"]]
    ]
]
    }
}
