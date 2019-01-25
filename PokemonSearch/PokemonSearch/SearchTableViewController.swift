//
//  SearchTableViewController.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    var pokemonController = PokemonController()
    
   /* override func viewDidLoad() {
        super.viewDidLoad()
    }
    */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        pokemonController.searchForPokemon(with: searchTerm.lowercased()) { (pokemons, error) in
            DispatchQueue.main.async {
                self.pokemons = pokemons ?? []
            }
        }
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! SearchTableViewCell

        let pokemon = self.pokemons[indexPath.row]
        cell.nameLabel.text = pokemon.name
        cell.idLabel.text = String(pokemon.id)
        cell.abilitiesLabel.text = pokemon.abilities.joined()
        cell.typeLabel.text = pokemon.types.joined()
    

        return cell
    }
    
    
    var pokemons: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
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
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    

}
