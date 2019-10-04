//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by macbook on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    let apiController = APIController()
    var pokemon: Pokemon?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        guard let searchTerm = searchBar.text else { return }
        
        getDetails(for: searchTerm)
        //updateViews()        TODO: Not sure if I need to call updateview here cause inside getDatial, it's being called

        
    }
    
    func getDetails(for pokemonName: String) {
        
        apiController.fetchPokemonDetails(for: pokemonName) { (result) in
            
            do {
                let pokemon = try result.get()
                
                DispatchQueue.main.async {
                    self.updateViews()
                }
                
                self.apiController.fetchImage(at: pokemon.imageURL) { (image) in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
                
            } catch {
                NSLog("Error fetching pokemon details: \(error)")
            }
        }
    }
    
    
    func updateViews() {
        
        if let pokemon = pokemon {
            title = pokemon.name
            nameLabel.text = pokemon.name
            idLabel.text = pokemon.id
            typesLabel.text = pokemon.types
            abilitiesLabel.text = pokemon.abilities
            
        } else {
            nameLabel.alpha = 0
            idLabel.alpha = 0
            typesLabel.alpha = 0
            abilitiesLabel.alpha = 0
        }
    }
}
