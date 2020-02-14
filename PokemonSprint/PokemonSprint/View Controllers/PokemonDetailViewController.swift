//
//  PokemonDetailViewController.swift
//  PokemonSprint
//
//  Created by Elizabeth Wingate on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet {
        updateViews()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            updatePokemonDetailViews(with: pokemon)
        } else {
            clearPokemonDetailViews()
        }
    }
      private func updatePokemonDetailViews(with pokemon: Pokemon) {
         pokemonController?.fetchImage(at: pokemon.spriteURL) { result in
             do {
                 let pokemonImage = try result.get()
                 self.updateImage(with: pokemonImage)
             } catch {
                 self.spriteImageView.image = nil
             }
         }

         DispatchQueue.main.async {
             self.nameLabel.text = pokemon.name.capitalized
             self.idLabel.text = "ID: " + String(pokemon.id)
             self.typesLabel.text = "Types: " + pokemon.typeNames.joined(separator: ", ").capitalized
             self.abilitiesLabel.text = "Abilities: " + pokemon.abilityNames.joined(separator: ", ").capitalized
         }
     }

     private func updateImage(with image: UIImage) {
         DispatchQueue.main.async {
             self.spriteImageView.image = image
         }
     }

     private func clearPokemonDetailViews() {
         DispatchQueue.main.async {
             self.nameLabel.text = ""
             self.idLabel.text = ""
             self.typesLabel.text = ""
             self.abilitiesLabel.text = ""
             self.spriteImageView.image = nil
         }
     }

}
