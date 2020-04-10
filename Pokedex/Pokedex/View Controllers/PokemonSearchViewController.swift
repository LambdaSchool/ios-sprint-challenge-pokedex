//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Dahna on 4/10/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBAction func savePokemonButtonTapped(_ sender: UIButton) {
    }
    
    var pokemonController: PokemonController?
    var searchedPokemon: Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func updateViews() {
        print("in update views")
        pokemonNameLabel.text = pokemonController?.searchedPokemon?.name
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        
//        guard let pokemonController = pokemonController else { return }
        
        
        self.pokemonController?.searchPokemon(searchTerm: searchTerm) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("should be updateViews")
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    
}

}
