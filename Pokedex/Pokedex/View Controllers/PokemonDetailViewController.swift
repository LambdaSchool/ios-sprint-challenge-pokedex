//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_204 on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    var pokemonResultController: PokemonResultController?
    var pokemon: PokemonResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        if let pokemon = pokemon {
            title = pokemon.name
            nameLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
        } else {
            title = "Pokemon Search"
        }
    }

    private func searchResults () {
        guard let pokemonResultController = pokemonResultController,
            let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        pokemonResultController.performSearch(for: searchTerm.lowercased()) { result in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.title = pokemon.name
                    self.nameLabel.text = pokemon.name
                    self.idLabel.text = String(pokemon.id)
                    self.abilitiesLabel.text = pokemon.abilities.map({$0.ability.name}).joined(separator: ", ")
                    self.typesLabel.text = pokemon.types.map({$0.type.name}).joined(separator: ", ")
                }
            } catch {
                print("Error getting pokemon! \(error)")
                
            }
        }
    }
    
    @IBAction func saveTapped(_ sender: UIButton){
        
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

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults()
    }
}
