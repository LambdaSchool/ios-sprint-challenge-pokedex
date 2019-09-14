//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Dillon P on 9/14/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import UIKit

protocol UpdatePokedex {
    func saveToPokedex(with pokemon: Pokemon)
}

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    
    let pokemonSearchController = PokemonController()
    var delegate: UpdatePokedex?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        pokemonSearchBar.delegate = self
        
        if pokemon == nil {
        pokemonName.isHidden = true
        pokemonImage.isHidden = true
        pokemonIdLabel.isHidden = true
        pokemonTypeLabel.isHidden = true
        pokemonAbilitiesLabel.isHidden = true
        savePokemonButton.isHidden = true
        } else {
            if let pokemon = pokemon {
                self.title = pokemon.name.capitalized
                updateViews(with: pokemon)
                savePokemonButton.isHidden = true
                pokemonSearchBar.isHidden = true
            }
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        delegate?.saveToPokedex(with: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    
    private func updateViews(with pokemon: Pokemon) {
        self.pokemon = pokemon
        pokemonName.isHidden = false
        pokemonImage.isHidden = false
        pokemonIdLabel.isHidden = false
        pokemonTypeLabel.isHidden = false
        pokemonAbilitiesLabel.isHidden = false
        savePokemonButton.isHidden = false
        pokemonName.text = pokemon.name.capitalized
        pokemonIdLabel.text = "ID: \(pokemon.id)"
        
        var abilityCount = 0
        var abilities = ""
        for _ in pokemon.abilities {
            abilities += "\(pokemon.abilities[abilityCount].ability.name.capitalized). "
            abilityCount += 1
        }
        pokemonAbilitiesLabel.text = "Abilities: \(abilities)"
        
        var typeCount = 0
        var types = ""
        for _ in pokemon.types {
            types += "\(pokemon.types[typeCount].type.name.capitalized). "
            typeCount += 1
        }
        pokemonTypeLabel.text = "Types: \(types)"
        
    }

}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        let pokemonName = searchTerm.lowercased()
        
        pokemonSearchController.searchForPokemon(with: pokemonName) { (result) in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
            } catch {
                print("Error setting pokemon object: \(error)")
            }
        }
    }
}

