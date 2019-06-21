//
//  PokedexSearchViewController.swift
//  Pokedex
//
//  Created by Kat Milton on 6/21/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import UIKit

class PokedexSearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonSprite: UIImageView!
    @IBOutlet var pokemonIDLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var saveButton: UIButton!

    var pokemonController = PokemonController()
    
    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        pokemonNameLabel.text = ""
        saveButton.setTitle("", for: .normal)

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        pokemonNameLabel.text = pokemon.name.capitalized
        let id = String(pokemon.id)
        pokemonIDLabel.text = "ID: \(id)"
        let type: [String] = pokemon.types.map { $0.type.name }
        typeLabel.text = "Type(s): \(type.joined(separator:", "))"
        let abilities: [String] = pokemon.abilities.map { $0.ability.name }
        abilitiesLabel.text = "Abilities: \(abilities.joined(separator: "\n"))"
        guard let url = URL(string: pokemon.sprites.front_default),
            let spriteData = try? Data(contentsOf: url) else { return }
        pokemonSprite.image = UIImage(data: spriteData)
        saveButton.setTitle("Save Pokemon", for: .normal)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        pokemonController.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
        print("Saving pokemon to list")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokedexSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        print("Searching")
        
        pokemonController.fetchPokemon(for: searchTerm) { (result, error) in
            if error != nil {
                NSLog("Error searching for: \(String(describing: error))")
            }
            self.pokemon = result
            DispatchQueue.main.async {
                self.updateViews()
                self.searchBar.text = ""
            }
        }
    }
}
