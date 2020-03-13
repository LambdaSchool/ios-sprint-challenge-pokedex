//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeslabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
        // MARK: - Properties
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()

    }
    
    private func updateViews() {
        if pokemon != nil {
        title = pokemon?.name
        nameLabel.text = pokemon?.name
        idLabel.text = "ID: \(String(describing: pokemon?.id))"
        abilitiesLabel.text = pokemon?.ability
        } else {
            self.title = "Pokemon Search"
        }
    }
    
    @IBAction func savePokemonTapped(_ sender: Any) {
        guard let name = nameLabel.text,
            let id = "ID: \(String(describing: pokemon?.id))",
            let ability = abilitiesLabel.text,
            let types = typeslabel.text,
            name != ""  else { retur }
            
            
        if let pokemon = pokemon {
            pokemonController?.addPokemon(withName: name, id: id, ability: ability, types: types)
        }
            self.navigationController?.popViewController(animated: true)
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
    func searchButtonClicked(_searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.pokemonSearch(searchTerm: searchTerm, completion: { error in
            if let error = error {
                NSLog("Error in search: \(error)")
            } else {
                self.updateViews()
            }
        })
    }
}
