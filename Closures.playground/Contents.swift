import UIKit


// a closure
let myNameClosure: (String) -> Void = { (name) in
    print(name)
}

myNameClosure("Joe")


// you can return things from a closure like this

let anotherNameClosure: (String) -> String = { (name) in
    print(name)
    return name.uppercased()
}

anotherNameClosure("Joe")

// a func doing the same thing

func print(name: String) {
    print(name)
}

print(name: "Spencer")

// CompletionHandlre




