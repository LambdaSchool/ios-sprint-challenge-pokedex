//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Zack Larsen on 12/6/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var IdLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchResult = searchBar.text,
            let pokemonController = pokemonController else {
                print("ApiDetailViewController: and animal name are required.")
                return
                
        }
        pokemonController.fetchDetails(for: searchResult) { (result) in
            do {
                guard let pokemon = self.pokemon else { return }
                var temp = pokemon
                temp = try result.get()
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
            } catch {
//                if let error = error {
////                    print("Error fetching pokemon")
////                }
////
            }
            
        }
        
    }
    
    private func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        displayName.text = pokemon.name
        //            IdLabel.text = pokemon.
        //        typesLabel.text = pokemon.types
        //        abilitiesLabel.text = pokemon.abilities
        //        pokemonImage.
        
    }
    
    
    
    // Do any additional setup after loading the view.
    
    
    @IBAction func savePokemonTapped(_ sender: UIButton) {
        
        //        guard let title =
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
