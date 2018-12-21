//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!

    @IBOutlet weak var pokemonIDText: UITextField!
    @IBOutlet weak var pokemonTypeText: UITextField!
    @IBOutlet weak var pokemonAbilitiesText: UITextField!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pokemonSave(_ sender: Any) {
    }
    
    func displayPokemon() {
        // Make sure we found a Pokemon
//        guard let pokemon = pokemon else {
// //           pokemonNameLabel.text = "Sorry, did not find that Pokemon"
//            return
//        }
        pokemonNameLabel.text = pokemon?.name
    }
    
    
    // MARK: - Search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pokemonSearchBar.autocapitalizationType = .none
        searchBar.resignFirstResponder()
        guard let findThisPokemon = searchBar.text?.lowercased(), !findThisPokemon.isEmpty else { return }
        
        // Clear the searchbar and set the placeholder text
        searchBar.text = ""
        searchBar.placeholder = findThisPokemon.lowercased()
        
        // Search the Pokemon API for the entered Pokemon name
        NetworkData.shared.searchForPokemon(with: findThisPokemon.lowercased()) { (error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.displayPokemon()
                }
            }
        }
   }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // End of class
