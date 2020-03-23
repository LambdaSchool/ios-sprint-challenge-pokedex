//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesTextView: UITextView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    var apiController: APIController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        
        guard let pokemon = pokemon else {
            title = "Pokemon Search"
            
            pokemonNameLabel.text = ""
            idLabel.text = ""
            pokemonAbilitiesTextView.text = ""
            pokemonTypeLabel.text = ""
            
            return
        }
        
        title = pokemon.name.capitalized
        
        pokemonNameLabel.text = pokemon.name.capitalized
        idLabel.text = " \(pokemon.id)"
        
        pokemonAbilitiesTextView.text = "Abilities: " + pokemon.abilities.map({ $0.ability.name.capitalized }).joined(separator: ", ")
        
        pokemonTypeLabel.text = " " + pokemon.types.map({ $0.type.name.capitalized }).joined(separator: ", ")
        
        self.apiController?.fetchImage(at: pokemon.sprites.imageURL, completion: { (image) in
            do {
                let image = try image.get()
                self.updateImage(with: image)
            } catch {
                self.pokemonImageView.image = nil
            }
        })
        
    }
    
    func updateImage(with image: UIImage) {
        DispatchQueue.main.async {
            self.pokemonImageView.image = image
        }
    }


}
