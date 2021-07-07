//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by BDawg on 11/4/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var apiController: APIController?
    var pokemon: Pokemon?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        fetchImage()
        // Do any additional setup after loading the view.
    }
    

    private func updateViews() {
        
        guard let _ = apiController,
        let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "Pokemon ID: \(pokemon.id)"
        
        let pokeTypes = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        typesLabel.text = "Types: \(pokeTypes)".capitalized
        
        let pokeAbilities = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        abilitiesLabel.text = "Abilities: \(pokeAbilities)".capitalized

    }
    
    func fetchImage() {
        
        apiController?.fetchImage(at: pokemon!.sprites.imageURL, completion: { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokeImage.image = image
                }
            }
        })
    }

}
