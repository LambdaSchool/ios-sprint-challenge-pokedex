//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Bradley Diroff on 3/13/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

protocol AddPokemonDelegate {
func pokemonWasAdded(_ item: Pokemon)
}

class PokeDetailViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var pokeName: UILabel!
    @IBOutlet var pokeImage: UIImageView!
    @IBOutlet var pokeStack: UIStackView!
    @IBOutlet var pokeId: UILabel!
    @IBOutlet var pokeTypes: UILabel!
    @IBOutlet var pokeAbilities: UILabel!
    
    @IBOutlet var pokeButton: UIButton!
    
    var delegate: AddPokemonDelegate?
    var searchController: SearchController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        if let pokemon = pokemon {
            updateView(pokemon: pokemon)
            searchBar.isHidden = true
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        guard let newPokemon = pokemon else {return}
        delegate?.pokemonWasAdded(newPokemon)
        navigationController?.popViewController(animated: true)
    }
    
    
    func updateView(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        if let nameIndex = pokemon.forms.first {
            pokeName.text = nameIndex.name.capitalizingFirstLetter()
            self.title = nameIndex.name.capitalizingFirstLetter()
        }
        
        var abilities = [String]()
        for ability in pokemon.abilities {
            abilities.append(ability.ability.name)
        }
        pokeAbilities.text = turnToString(abilities, type: "Abilities: ").capitalizingFirstLetter()
        
        var types = [String]()
        for type in pokemon.types {
            types.append(type.type.name)
        }
        pokeTypes.text = turnToString(types, type: "Types: ").capitalizingFirstLetter()
        
        pokeId.text = "ID: \(pokemon.id)"
        
        if let pokePic = getThePhoto(id: pokemon.id) {
            pokeImage.image = pokePic
            pokeImage.contentMode = .scaleAspectFit
        }
    }

}

func getThePhoto(id: Int) -> UIImage? {
    let url = URL(string:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(id).png")
    if let data = try? Data(contentsOf: url!), let image: UIImage = UIImage(data: data)
    {
      return image
    }
    return nil
}

func turnToString(_ array: [String], type: String) -> String {
     
     switch array.count {
     case 0:
         return ""
     case 1:
         return "\(type) \(array[0])"
     case 2:
         return "\(type) \(array[0]) and \(array[1])"
     case 3...:
         var sayType = type
         for num in 0..<array.count {
             if num == (array.count-1) {
                 sayType += " and \(array[num])"
             } else {
                 sayType += " \(array[num]),"
             }
         }
         return sayType
     default:
         return ""
     }
}

extension PokeDetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        
        if searchText != "" {
            
        searchController?.fetchPokemon(for: searchText) { result in
                  if let newPokemon = try? result.get() {
                      DispatchQueue.main.async {
                        self.updateView(pokemon: newPokemon)
                        self.pokeButton.isHidden = false
                      }
            }
            }
        
        }
        
    }
    
}
