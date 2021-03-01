//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Craig Belinfante on 1/4/21.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        
        // Configure the cell...
        let pokemon = pokemonController.pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemon" {
            if let searchVC = segue.destination as? DetailViewController {
                searchVC.pokemonController = pokemonController
            }
        } else if segue.identifier == "ViewPokemon" {
            if let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                
                let pokemon = pokemonController.pokemonList[indexPath.row]
                detailVC.pokemon = pokemon
                detailVC.pokemonController = pokemonController
            }
        }
    }
    
    
}
