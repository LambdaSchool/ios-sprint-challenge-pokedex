//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Welinkton on 9/21/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    // enable delete, prepare the segues, row and cell for row, (DidSelectRow?),View Will appear?
    
    var pokemonController = PokemonController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokedex.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
            cell.textLabel?.text = pokemonController.pokedex[indexPath.row].name
        
            return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { if editingStyle == .delete {
        
        pokemonController.pokedex.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    }
    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let destinationVC = segue.destination as? PokemonSearchViewController else {return}
            
            destinationVC.pokemonController = pokemonController
            
        }else if segue.identifier == "ShowDetailSegue"{
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {return}
            
            let pokemon = pokemonController.pokedex[indexPath.row]
            destinationVC.pokemon = pokemon
            
        }
    }
    

}
