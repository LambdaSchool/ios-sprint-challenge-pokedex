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
    
    //MARK: Properties
    
    var pokemon: Pokemon?
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    //MARK: Private
    
    private func updateViews() {
        if let pokemon = pokemon {
            let name = pokemon.name.prefix(1).uppercased() + pokemon.name.dropFirst()
            
            self.title = name
            nameLabel.text = name
        }
    }
}

//MARK: Search Bar Delegate

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.view.endEditing(true)
        if let search = searchBar.text,
            !search.isEmpty{
            pokemonController.getPokemon(from: search) { (result) in
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
