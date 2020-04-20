//
//  SearchTableViewController.swift
//  Pokedex Sprint Challenge
//
//  Created by Mark Poggi on 4/10/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

       let searchPokemonController = SearchPokemonController()
        var pokemon: Pokemon?
        
    @IBOutlet weak var searchBar: UISearchBar!
 

    override func viewDidLoad() {
            super.viewDidLoad()
//            searchBar.delegate = self
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchTerm = searchBar.text,
                searchTerm != "" else { return }
            
            searchPokemonController.performSearch(for: searchTerm) {
                DispatchQueue.main.async {
                        
                    }
                }
            }
        
        // MARK: - Table view data source
           
           override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pokemo
           }
           
           override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
               
               let pokemon = searchPokemonController.pokemons[indexPath.row]
               cell.textLabel?.text = pokemon.name
               return cell
           }
     
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
}
