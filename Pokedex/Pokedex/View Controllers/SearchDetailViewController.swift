//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Chris Dobek on 4/10/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var apiController: APIController? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
        searchBar.delegate = self
    
    }
    
    func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        apiController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        apiController?.deletePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
            guard isViewLoaded else {return}
            guard let pokemonObject = pokemon else {
                title = "Pokemon Search"
                print("Labels not updated")
                return
            }

            print("\(pokemonObject.name) set in detail view")
            title = pokemonObject.name.capitalized
            pokemonNameLabel.text = pokemon?.name
            idLabel.text = "ID: \(pokemonObject.id)"

            var types: [String] = []
            for typeInfo in pokemonObject.types {
                types.append(typeInfo.type.name)
            }

            typeLabel.text = "\(types.joined(separator: ", "))"
            abilityLabel.text = "\(pokemonObject.abilities[0].ability.name)"

            apiController?.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { (pokemonImage) in
                DispatchQueue.main.async {
                    self.imageView.image = pokemonImage
                }
            })
        }
    

}

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        apiController?.fetchPokemon(pokemonName: searchTerm) { (pokemonObject) in
            
            guard let pokemon = try? pokemonObject.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
        
        guard let pokemonImgURL = pokemon?.sprites.imageUrl else { return }
        apiController?.fetchImage(from: pokemonImgURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
}
