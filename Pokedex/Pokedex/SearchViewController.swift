//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Gladymir Philippe on 7/17/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var apiController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        updateViews()
    }
    
    func hideKeyBoard() {
        searchBar.resignFirstResponder()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        apiController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemonObject = pokemon else {
            title = "Pokemon Search"
            print("Label is not updated")
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
        
        typesLabel.text = "\(types.joined(separator: ","))"
        abilitiesLabel.text = "\(pokemonObject.abilities[0].ability.name)"
        
        apiController?.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.imageView.image = pokemonImage
            }
        })
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

} 
