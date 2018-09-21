//
//  PokemonListTableViewController.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PokemonListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let pokemonController = PokemonController()
    
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        let pokemon = pokemonController.pokedex[indexPath.row]
        
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = pokemonController.pokedex[indexPath.row]
            pokemonController.deletePokemon(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchBarButtonSegue" {
            let destinationVC = segue.destination as! SearchPokemonTableViewController
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "TableCellSegue" {
            let destionationVC = segue.destination as! PokemonDetailViewController
            destionationVC.pokemonController = pokemonController
            
            guard let index = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokedex[index.row]
            
            destionationVC.pokemon = pokemon
        }
    }
}
