//
//  PokemonModel.swift
//  Podex II
//
//  Created by Ivan Caldwell on 12/14/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
class PokemonModel: Codable {
    static let shared = PokemonModel()
    private init () {}
    var storedString: String = ""
    var pokemons: [Pokemon] = [] {
        didSet {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            do {
                let data = try encoder.encode(pokemons)
                storedString = String(data: data, encoding: .utf8)!
            } catch { print(error) }
            saveData()
        }
    }
    
    let fileURL = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Library")
        .appendingPathComponent("Pokemon")
        .appendingPathComponent("List")
        .appendingPathExtension("txt")
    
    func saveData() {
        try! (storedString).write(to: fileURL, atomically: false, encoding: .utf8)
    }

    func loadData() {
        do {
            pokemons = try JSONDecoder().decode([Pokemon].self, from: Data(contentsOf: fileURL))
        } catch { print(error) }
    }
}
