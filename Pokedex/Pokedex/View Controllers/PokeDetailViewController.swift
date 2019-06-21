//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Jake Connerly on 6/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit



class PokeDetailViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
     @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokeController: PokeController?
    var pokemon: PokeMon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate? = self
    }
   
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        getPokemon()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
    }
    
    
    

    func getPokemon() {
        guard let pokeController = pokeController,
            let pokemonSearch = searchBar.text else { return }
        let pokemon = String(pokemonSearch).lowercased()
        pokeController.fetchPokemon(for: pokemon) { result in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(wit: pokemon)
                }
            }
        }
    }
    
    func updateViews(wit pokeMon: PokeMon) {
        pokemonNameLabel?.text = pokeMon.name
        pokemonImageView.image = UIImage(data: pokeMon.sprites)
        idLabel?.text = String(pokeMon.id)
        typeLabel?.text = pokeMon.types
        abilityLabel?.text = pokeMon.abilities
    }

}

//extension PokeDetailViewController: UISearchBarDelegate {
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        getPokemon()
//    }
//
//}


//UIImage(data: photo.imageData)
