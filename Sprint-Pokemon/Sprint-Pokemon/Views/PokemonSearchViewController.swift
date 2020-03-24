//
//  PokemonSearchViewController.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            updateViews(pokemon: pokemon)
        }
    }
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews(pokemon: pokemon)
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var spriteNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spriteImage: UIImageView!
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
            guard let pokemon = pokemon else { return }
        
            pokemonController?.addPokemon(pokemon: pokemon)
            DispatchQueue.main.async {
           self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews(pokemon: pokemon)
        searchBar.delegate = self
    }
    
    func updateViews(pokemon: Pokemon?) {
        if let pokemon = pokemon {
            self.title = pokemon.name
            spriteNameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            var types: [String] = []
            for typeInfo in pokemon.types {
                types.append(typeInfo.type.name)
            }
            typeLabel.text = "\(types.joined(separator: ", "))"
            abilitiesLabel.text = "\(pokemon.abilities[0].ability.name)"
        }
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController!.performSearch(searchTerm: searchTerm) { (result) in
            
            guard let pokemon = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
            self.pokemonController!.fetchImage(at: pokemon.sprites.imageURL) { (result) in
                guard let image = try? result.get() else { return }
                
                DispatchQueue.main.async {
                    self.spriteImage.image = image
                }
            }
        }
    }
}
