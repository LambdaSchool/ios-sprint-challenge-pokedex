//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_201 on 11/9/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
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
    
    
    
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
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
        searchBarOutlet.delegate = self
    }
    
    func hideKeyboard() {
        searchBarOutlet.resignFirstResponder()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else {return}
        apiController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else {return}
        apiController?.delete(pokemon: pokemon)
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
     func searchBarSearchButtonClicked(_ sender: UISearchBar) {
        guard let searchTerm = searchBarOutlet.text else { return }

         apiController?.fetchPokemon(pokemonName: searchTerm) { (pokemonObject) in

             guard let pokemon = try? pokemonObject.get() else { return }


              DispatchQueue.main.async {
                 self.pokemon = pokemon
             }
         }
        
        guard let pokemonImgUrl = pokemon?.sprites.imageUrl else {return}
        apiController?.fetchImage(from: pokemonImgUrl, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
        
    }
}
