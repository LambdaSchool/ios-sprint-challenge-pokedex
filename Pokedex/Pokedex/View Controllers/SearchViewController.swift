//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Chad Parker on 3/20/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

protocol SearchDelegate {
    func save(_ pokemon: Pokemon)
}

class SearchViewController: UIViewController {
    
    var apiController: APIController!
    var delegate: SearchDelegate?
    
    private var pokemonVC: PokemonViewController!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideViews(true)
        searchBar.searchTextField.becomeFirstResponder()
    }    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pokemonVC = segue.destination as? PokemonViewController else { return }
        
        self.pokemonVC = pokemonVC
        pokemonVC.apiController = self.apiController
    }
    
    private func hideViews(_ hidden: Bool) {
        pokemonVC.view.isHidden = hidden
        saveButton.isHidden = hidden
    }
    
    @IBAction func saveButtonWasPressed(_ sender: Any) {
        guard let pokemon = pokemonVC.pokemon else { return }
        delegate?.save(pokemon)
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        
        apiController.getPokemon(query) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.pokemonVC.pokemon = pokemon
                    self.hideViews(false)
                    self.searchBar.searchTextField.resignFirstResponder()
                }
            case .failure(let networkError):
                print("network error: \(networkError)")
            }
        }
    }
}
