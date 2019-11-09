//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Alex Thompson on 11/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
        searchBar.delegate = self
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let pokemon = pokemon else { return }
        pokemonController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.deletePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else {
            title = "Pokemon Search"
            print("Labels not updated")
            return }
        
        print("\(pokemonObject.name) set in detail view")
        title = pokemonObject.name.capitalized
        pokemonNameLabel.text = pokemon?.name
        idLabel.text = "ID: \(pokemonObject.id)"
        
        var types: [String] = []
        for typeInfo in pokemonObject.types {
            types.append(typeInfo.type.name)
        }
        
        typeLabel.text = "Pokemon Type: \(types.joined(separator: ", "))"
        abilityLabel.text = "Abilities: \(pokemonObject.abilities[0].ability.name)"
        
        pokemonController?.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { pokemonImage in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
}
extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.fetchPokemon(pokemonName: searchTerm, completion: { pokemonObject in
            guard let pokemon = try? pokemonObject.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        })
        guard let pokemonImgUrl = pokemon?.sprites.imageUrl else { return }
        pokemonController?.fetchImage(from: pokemonImgUrl, completion: { pokemonImage in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
}
