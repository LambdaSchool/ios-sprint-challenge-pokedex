//
//  PokemonDetailViewController.swift
//  PokedexSprint3
//
//  Created by Jaspal on 1/25/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetailView()
    }
    
    @IBOutlet weak var pokemonTitleName: UINavigationItem!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonTypes: UILabel!
    @IBOutlet weak var pokemonAbilities: UILabel!
    @IBOutlet weak var pokemonSprite: UIImageView!
    
    
    func updateDetailView() {

        guard let presentedPokemon = self.savedPokemon else { fatalError("Could not obtain Pokemon.")}
        
        pokemonTitleName.title = presentedPokemon.name
        
        pokemonName.text = presentedPokemon.name
        
        pokemonID.text = "ID: \(presentedPokemon.id)"
        
        pokemonTypes.text = "Types: \(presentedPokemon.types.compactMap({$0.type.name}).joined(separator: ", "))"
        
        pokemonAbilities.text = "Abilities: \(presentedPokemon.abilities.compactMap({$0.ability.name}).joined(separator: ", "))"
        
        guard let urlString = presentedPokemon.sprites?.frontDefault else { return }
        
        guard let imageURL = URL(string: urlString), let imageData = try? Data(contentsOf: imageURL) else { fatalError("Couldn't obtain image.")}
        
        self.pokemonSprite?.image = UIImage(data: imageData)
        
    }
    
    // MARK: Properties
    
    var savedPokemon: Pokemon?
    
}
