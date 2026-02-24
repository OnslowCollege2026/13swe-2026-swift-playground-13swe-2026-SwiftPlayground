// The Swift Programming Language
// https://docs.swift.org/swift-book

@main

struct SwiftPlayground {
    static func main() {
func accepts(input: String, isValid: (String) -> Bool) -> Bool {
    return isValid(input)
}

let sample = "moonlIght"
print(accepts(input: sample, isValid: { $0 == $0.lowercased() && $0.count > 8}))



        let sightings = [
    (name: "moth", score: 3),
    (name: "wolf", score: 9),
    (name: "raven", score: 4),
    (name: "mist", score: 7),
    (name: "wisp", score: 2)
]
    let M_Ws = sightings.filter { seen in return (seen.name).first == "m" || (seen.name).first == "w"}
    let Jscores = M_Ws.map{($0.score)}
    let result = Jscores.reduce(0) { result, jscore in
    return result + jscore
    }
    let maxValue = Jscores.max { $0 < $1}
    let minValue = Jscores.min { $0 < $1}
    print (minValue!, maxValue!, result, M_Ws)




        let mixed = ["cat", "7", "owl", "15", "dog", "3"]
        let pure = mixed.compactMap { Int($0) }
        print(pure)

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
    //let wing = archive.last {shelf in shelf.contains {$0.hasPrefix("e")}}
}
}