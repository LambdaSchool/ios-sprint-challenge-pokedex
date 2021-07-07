//
//  SearchDetailViewController.swift
//  ios-Sprint-Challenge-Pokedex
//
//  Created by Jonalynn Masters on 10/5/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var abilityLabel: UILabel!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var deleteButton: UIButton!
    
    //MARK: Properties
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    // MARK: Save
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let pokemon = pokemon else { return }
        apiController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        apiController?.delete(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Update Views Function
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else {
            title = "Pokemon Search"
            print("Labels not updated")
            return }
        
        print("\(pokemonObject.name) set in detail view")
        title = pokemonObject.name.capitalized
        pokemonNameLabel.text = pokemon?.name
        idLabel.text = "\(pokemonObject.id)"
        
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
        guard let searchTerm = searchBar.text else { return }

        apiController?.fetchPokemon(pokemonName: searchTerm) { (pokemonObject) in
                
            guard let pokemon = try? pokemonObject.get() else { return }
            
            
             DispatchQueue.main.async {
                 self.pokemon = pokemon
             }
         }
         guard let pokemonImgUrl = pokemon?.sprites.imageUrl else { return }
        apiController?.fetchImage(from: pokemonImgUrl, completion: { (pokemonImage) in
             DispatchQueue.main.async {
                
                self.imageView.image = pokemonImage
             }
         })
     }
 }


