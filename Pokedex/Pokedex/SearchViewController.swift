//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Nathanael Youngren on 1/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        guard let pokemonController = pokemonController else { return }
        pokemonController.searchPokemon(with: "Eevee", completion: { (result, error) in
            if let error = error {
                print(error)
                return
            }

            DispatchQueue.main.async {
                self.result = result
                self.updateViews()
            }
        })
    }
    
    func updateViews() {
        guard let result = result else { return }
        nameLabel.text = result.name
        idLabel.text = String("\(result.id)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty,
        let pokemonController = pokemonController else { return }
        pokemonController.searchPokemon(with: searchTerm, completion: { (result, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.result = result
                self.updateViews()
            }
        })
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let result = result else { return }
        pokemonController?.savePokemon(pokemon: result)
        navigationController?.popViewController(animated: true)
    }
    
    var pokemonController: PokemonController?
    
    var result: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    

}
