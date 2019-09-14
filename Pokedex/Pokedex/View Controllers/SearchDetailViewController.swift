//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Vici Shaweddy on 9/13/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import UIKit

protocol SearchDetailDelegate {
    func didSave(pokemon: Pokemon)
}

enum ViewType {
    case search
    case detail
}

class SearchDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveButton: UIButton!
    
    let pokemonController = PokemonController()
    var viewType: ViewType?
    var delegate: SearchDetailDelegate?
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch viewType {
        case .search?:
             self.searchBar.isHidden = false
        case .detail?:
            self.searchBar.isHidden = true
        case .none:
            break
        }
        
        self.saveButton.isHidden = true
        self.searchBar.delegate = self
        updateView()
    }
    
    private func updateView() {
        self.nameLabel.text = pokemon?.name.capitalized
        self.idLabel.text = pokemon.map { "ID: \($0.id)" }
        
        let types = pokemon?.types.map { type in type.name }.joined(separator: ", ")
        self.typesLabel.text = types.map { "Types: \($0.capitalized)" }
        
        // to get the names and join them with comma
        let abilities = pokemon?.abilities.map { ability in ability.name }.joined(separator: ", ")
        // get rid of the optional using map
        self.abilitiesLabel.text = abilities.map { "Abilities: \($0.capitalized)" }
        
        if let name = pokemon?.name {
            self.navigationItem.title = name.capitalized
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        if let pokemon = self.pokemon {
            // pass the pokemon back to delegate(pokemontableviewcontroller)
            self.delegate?.didSave(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
        }
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

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }
        
        pokemonController.searchPokemon(with: query) { (result) in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateView()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        searchBar.endEditing(true)
        self.saveButton.isHidden = false
    }
}
