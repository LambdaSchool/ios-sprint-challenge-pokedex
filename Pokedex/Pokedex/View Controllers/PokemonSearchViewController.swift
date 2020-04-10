//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Dahna on 4/10/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
        guard let pokemonController = pokemonController else { return }
        guard let pokemon = pokemonController.searchedPokemon else {
            print("There is no Pokemon to save")
            return
        }
        pokemonController.savePokemon(pokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
    var pokemonController: PokemonController?
    var displayPokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self
        
    }
    
    
 
     // MARK: - Navigation
     
  
    
    func updateViews() {
        print("in update views")
        guard let unwrappedPokemon = displayPokemon else { return }
        
        guard let urlPath = unwrappedPokemon.sprites["front_default"],
            let imageURL = urlPath else {
                print("Error, no imageURL found")
                return
        }
        
        
        
        pokemonSpriteImage.loadSprite(url: imageURL)
        pokemonNameLabel.text = unwrappedPokemon.name.capitalized
        pokemonIDLabel.text = "ID: " + String(unwrappedPokemon.id)
        print(unwrappedPokemon.abilities)
        
        
        var abilitiesIndex = 0
        
        var abilities = unwrappedPokemon.abilities.count > 1 ? "Abilities: " : "Ability: "
        while abilitiesIndex < unwrappedPokemon.abilities.count {
            if abilitiesIndex > 0 {
                abilities.append(contentsOf: ", ")
            }
            
            guard let ability = unwrappedPokemon.abilities[abilitiesIndex].ability else { return }
            var capitalizedName: String = ""
            capitalizedName.append(contentsOf: ability.name!.prefix(1).uppercased())
            capitalizedName.append(contentsOf: ability.name!.dropFirst())
            abilities.append(contentsOf: capitalizedName)
            abilitiesIndex += 1
        }
        
        var typesIndex = 0
        var pokeType = unwrappedPokemon.types.count > 1 ? "Types: " : "Type: "
        while typesIndex < unwrappedPokemon.types.count {
            if typesIndex > 0 {
                pokeType.append(contentsOf: ", ")
            }
            
            guard let types = unwrappedPokemon.types[typesIndex].type else { return }
            var capitalizedName: String = ""
            capitalizedName.append(contentsOf: types.name!.prefix(1).uppercased())
            capitalizedName.append(contentsOf: types.name!.dropFirst())
            pokeType.append(contentsOf: capitalizedName)
            typesIndex += 1
        }
        
        pokemonAbilitiesLabel.text = abilities
        pokemonTypesLabel.text = pokeType
        
    }
    
    
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        self.pokemonController?.searchPokemon(searchTerm: searchTerm) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("should be updateViews")
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
