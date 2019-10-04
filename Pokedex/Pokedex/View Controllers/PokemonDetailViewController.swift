//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Isaac Lyons on 10/4/19.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: Properties
    
    var pokemon: Pokemon?
    var pokemonController: PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        updateViews()
    }
    
    //MARK: Private
    
    private func updateViews() {
        if let pokemon = pokemon {
            saveButton.isEnabled = true
            saveButton.isHidden = false
            nameLabel.isHidden = false
            
            let name = pokemon.name.prefix(1).uppercased() + pokemon.name.dropFirst()
            self.title = name
            nameLabel.text = name
        } else {
            saveButton.isEnabled = false
            saveButton.isHidden = true
            nameLabel.isHidden = true
        }
        
        if pokemonController == nil {
            searchBar.isHidden = true
            saveButton.isEnabled = false
            saveButton.isHidden = true
        } else {
            searchBar.isHidden = false
        }
    }
    
    //MARK: Actions
    
    @IBAction func saveTapped(_ sender: UIButton) {
        if let pokemon = pokemon {
            pokemonController?.pokemonList.append(pokemon)
            navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: Search Bar Delegate

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.view.endEditing(true)
        if let search = searchBar.text,
            !search.isEmpty{
            pokemonController?.getPokemon(from: search) { (result) in
                do {
                    let pokemon = try result.get()
                    DispatchQueue.main.async {
                        self.pokemon = pokemon
                        self.updateViews()
                    }
                } catch {
                    print("Error getting pokemon: \(error)")
                }
            }
        }
    }
}
