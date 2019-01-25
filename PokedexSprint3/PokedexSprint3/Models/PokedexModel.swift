//
//  PokedexModel.swift
//  PokedexSprint3
//
//  Created by Jaspal on 1/25/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import Foundation

class PokedexModel {
    
    static let shared = PokedexModel()
    private init() {}
    
    var savedPokemon: [Pokemon] = []
    var selectedPokemon: Pokemon?
    
    func savePokemon() {
        guard let selectedPokemon = selectedPokemon else { return }
        savedPokemon.append(selectedPokemon)
    }
    
    func removePokemon(indexPath: IndexPath) {
        savedPokemon.remove(at: indexPath.row)
    }
    
}
