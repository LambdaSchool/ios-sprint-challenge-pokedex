import UIKit
import Foundation

//func sendMessageTo(name: String, message: (String) -> String) {
//    print(message(name))
//}
//
//sendMessageTo(name: "Steve") { "Hello " + $0 }
//
//let closure = { (a: Int, b: Int) -> Int in
//    return a + b
//}
//
//func doMath(withA a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
//    let result = operation(a, b)
//    print("Result is \(result)")
//    return operation(a, b)
//}
//
//doMath(withA: 3, b: 7) { (a, b) -> Int in
//    return a + b
//}
//
//print(closure(2, 3))
//
//
//func repeatCount(with pharse: String, count: Int, operation: (String, Int) -> String) -> String {
//    let result = operatoin(pharse, count)
//    print(result)
//    return operation
//}

let repeats = { (pharse: String, count: Int) -> String in

    var newPharse = ""
    for _ in 1...count {
        newPharse = newPharse + pharse
    }
    
    return newPharse
}
    
    
print(repeats("Hello", 10))










//struct Employee: Codable {
//    var name: String
//    var id: Int
//    var favoriteToy: Toy
//
//    enum CodingKeys: String, CodingKey {
//        case id = "employeeID"
//        case name
//        case favoriteToy
//    }
//}
//
//struct Toy: Codable {
//    var name: String
//}
//
//let toy1 = Toy(name: "Teddy Bear")
//let employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)
//
//let jsonEncoder = JSONEncoder()
//let jsonData = try jsonEncoder.encode(employee1)
//
//print(jsonData)
//
//let jsonString = String(data: jsonData, encoding: .utf8)
//
//print(jsonString as Any)
//
//let jsonDecoder = JSONDecoder()
//let employee2 = try jsonDecoder.decode(Employee.self, from: jsonData)















//struct Pokemon: Codable {
//
//    let name: String
//    let abilities: [Ability]
//
//    struct Ability: Codable {
//        let ability: SubAbility
//
//        struct SubAbility: Codable {
//            let name: String
//        }
//    }
//}
//let baseURL = "google.com"
//let name = "eevee"
//
//let requestURL = baseURL
//    .appendingPathComponent("api")
//    .appendingPathComponent("v2")
//    .appendingPathComponent("pokemon")
//    .appendingPathComponent(name)
