import Cocoa
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let url: URL! = URL(string: "https://pokeapi.co/docs/v2/pokemon/ditto/")

let task = URLSession.shared.dataTask(with: url) { data, status, error
    in
    
    guard let status = status as? HTTPURLResponse else { fatalError() }
    guard status.statusCode == 200 else {
        print("Invalid status: \(status.statusCode)")
        return
    }
    print ("Okay status code")
    
    
}

task.resume()
