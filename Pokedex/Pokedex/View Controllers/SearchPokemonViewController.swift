//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Dahna on 5/8/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController {
    
    var pokemonController: PokemonController?
    
    var displayPokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemonController = pokemonController,
            let pokemon = pokemonController.searchedPokemon else {
            return
        }
        
        pokemonController.savePokemon(pokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    func updateViews() {
        guard let pokemon = displayPokemon else {
            print("no pokemon")
            return
        }
        guard let urlPath = pokemon.sprites["front_default"],
            let spriteURL = urlPath else { return }
        
        spriteImageView.loadSprite(url: spriteURL)
        pokeNameLabel.text = pokemon.name.capitalized
        pokeIDLabel.text = "ID: \(pokemon.id)"
        
        var typesIndex = 0
        var abilitiesIndex = 0
        
        var abilities = pokemon.abilities.count > 1 ? "Abilities: " : "Ability "
        while abilitiesIndex < pokemon.abilities.count {
            if abilitiesIndex > 0 {
            abilities.append(contentsOf: ", ")
        }
        
            guard let ability = pokemon.abilities[abilitiesIndex].ability else { return }
            var capitalizedName: String = ""
            capitalizedName.append(contentsOf: ability.name!.prefix(1).uppercased())
            capitalizedName.append(contentsOf: ability.name!.dropFirst())
            abilities.append(contentsOf: capitalizedName)
            abilitiesIndex += 1
        }
        
        var pokeType = pokemon.types.count > 1 ? "Types: " : "Type: "
        while typesIndex < pokemon.types.count {
            if typesIndex > 0 {
                pokeType.append(contentsOf: ", ")
            }
            
            guard let types = pokemon.types[typesIndex].type else { return }
            var capitalizedName: String = ""
            capitalizedName.append(contentsOf: types.name!.prefix(1).uppercased())
            capitalizedName.append(contentsOf: types.name!.dropFirst())
            pokeType.append(contentsOf: capitalizedName)
            typesIndex += 1
        }
        
        typesLabel.text = pokeType
        abilitiesLabel.text = abilities
        
    }
}

extension SearchPokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text,
            !search.isEmpty else { return }
        
        self.pokemonController?.fetchPokemon(searchTerm: search) { (error) in
            if let error = error {
                print("Failure to search for pokmeon. Error: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.displayPokemon = self.pokemonController?.searchedPokemon
                self.updateViews()
            }
        }
    }
}

extension UIImageView {
    func loadSprite(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
