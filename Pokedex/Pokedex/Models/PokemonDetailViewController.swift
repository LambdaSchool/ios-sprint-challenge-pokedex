//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bhawnish Kumar on 3/13/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonController: PokemonController?
    
    var pokemon: Pokemon?  {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var abilities: UILabel!
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
getDetails()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        getDetails()
        if let pokemon = pokemon {
            addingPokemon(with: pokemon)
        }
    }
   private func getDetails() {
        guard let pokemon = pokemon else { return }
        
        // call the apiController's get details method
                // fetch the image
    self.pokemonController?.fetchImage(at: pokemon.sprites.defaultSpriteUrl, completion: { result in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.pokemonImage.image = image
        self.addingPokemon(with: pokemon)
                        }
                    }
                })
            }
        private func addingPokemon(with pokemon: Pokemon) {
            pokemonName.text = pokemon.name
           idLabel.text = "ID: " + String(pokemon.id)
           types.text = "Types: \(pokemon.types)"
            abilities.text = "Abilities: \(pokemon.ability)"
           
        }
    


}

