//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/14/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController, UISearchBarDelegate {
    
    let reuseIdentifier = "PokemonCell"
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonSearchBar.delegate = self
    }
    
    @IBAction func savePokemon(_ sender: Any) {
    }
    
    // MARK: - Search for Pokemon
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        searchBar.text = ""
        searchBar.placeholder = searchTerm
        
        SearchController.shared.performSearch(with: searchTerm) { error in
            if error == nil {
                DispatchQueue.main.async {
                //self.tableView.reloadData()
                }
            }
        }
    } // End of search bar functionality
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //End of class
