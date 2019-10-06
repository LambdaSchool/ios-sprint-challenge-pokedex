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

        // Do any additional setup after loading the view.
    }
    //MARK: Update Views Function
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else { return }
        pokemonNameLabel.text = pokemon?.name
        idLabel.text = "\(pokemonObject.id)"
        
        var types: [String] = []
        for typeInfo in pokemonObject.types {
            types.append(typeInfo.type.name)
        }
        
        typeLabel.text = "\(types.joined(separator: ", "))"
        abilityLabel.text = "\(pokemonObject.abilities[0].ability.name)"
    }
}
 extension SearchDetailViewController: UISearchBarDelegate {
     func searchBarSearchButtonClicked(_ sender: UISearchBar) {
         guard let searchTerm = searchBar.text,
             let apiController = apiController else {
                 return
         }
           apiController.fetchPokemon(pokemonName: searchTerm) { (pokemonObject, error) in
                if let error = error {
                    print("Error searching pokemon: \(error)")
                    return
                }
             DispatchQueue.main.async {
                 self.pokemon = pokemonObject
             }
         }
         guard let pokemonImgUrl = pokemon?.sprites.imageUrl else { return }
        apiController.fetchImage(from: pokemonImgUrl) { (pokemonImage) in
             DispatchQueue.main.async {
 //                self.imageView.image = pokemonImage
             }
         }
     }
 }


