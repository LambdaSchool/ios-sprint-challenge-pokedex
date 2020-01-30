//
//  PokemonTableViewController.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonController.pokemons[indexPath.row].name

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        // Implement here
        let pokemon = pokemonController.pokemons[indexPath.row]
        pokemonController.delete(pokemon: pokemon)
        tableView.reloadData()
        
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetail" {
            guard let cellDetailController = segue.destination as? PokemonDetailViewController else { return }
            
            cellDetailController.pokemonController = pokemonController
            //cellDetailController.pokemon = cell.pokemon
            
        } else if segue.identifier == "PokemonSearch" {
            guard let searchController = segue.destination as? SearchTableViewController else { return }
            
            searchController.pokemonController = pokemonController
            
        }
        
    }
    
    
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    
    

}
