//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Waseem Idelbi on 3/22/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var apiController: PokemonController? {  // Added computed property here
        didSet {
            updateViews()
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    //MARK: -Methods and IBActions-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()  //Added this
    }
    
    func hideKeyBoard() {   //Added this function
        searchBar.resignFirstResponder()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {    // I addd this function implementation as a gift !!!
        guard let pokemon = pokemon else { return }
        apiController?.addPokemon(pokemon: pokemon)
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
        nameLabel.text = pokemon?.name
        idLabel.text = "ID: \(pokemonObject.id)"
        
        var types: [String] = []
        for typeInfo in pokemonObject.types {
            types.append(typeInfo.type.name)
        }
        
        typesLabel.text = "\(types.joined(separator: ", "))"
        abilitiesLabel.text = "\(pokemonObject.abilities[0].ability.name)"
        
        apiController?.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
    }
    
} //End of class


extension SearchViewController: UISearchBarDelegate {
    
     func searchBarSearchButtonClicked(_ sender: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }

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
    
} //End of extension
