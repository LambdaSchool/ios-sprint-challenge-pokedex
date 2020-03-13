//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Shawn Gee on 3/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // MARK: - Properties
    
    var pokeApiClient: PokeApiClient?
    var pokemon: Pokemon? { didSet { updateViews() }}
    
    
    // MARK: - Private
    
    private func updateImageView() {
        guard let pokemon = pokemon, let pokeApiClient = pokeApiClient else { return }
        
        guard let imageUrlString = pokemon.sprites.frontDefault else { return }
    
        pokeApiClient.fetchImage(for: imageUrlString) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imageView.image = image
                case .failure(let error):
                    NSLog("\(error)")
                }
            }
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon, isViewLoaded else { return }
        title = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        let types = pokemon.types.map { $0.type.name }.joined(separator: ", ")
        typesLabel.text = "Types: \(types)"
        let abilities = pokemon.abilities.map { $0.ability.name }.joined(separator: ", ")
        abilitiesLabel.text = "Abilities: \(abilities)"
        
        updateImageView()
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
}
