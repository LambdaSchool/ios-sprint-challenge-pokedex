//
//  PokemonTableViewController.swift
//  Pokemon
//
//  Created by Michael Flowers on 5/10/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pc = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction func search(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pc.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let pokemon = pc.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let pokemonToDelete = pc.pokemons[indexPath.row]
            pc.delete(pokemon: pokemonToDelete)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass the pc to the searchDetailVC so that it can use its class methods
        if segue.identifier == "SearchSegue" {
            let destinationVC = segue.destination as! SearchPokemonViewController
            destinationVC.pc = pc
        }
        
        if segue.identifier == "CellSegue" {
            //we need to pass both the pc and the pokemon at the cell that was pressed
            guard let destinationVC = segue.destination as? SearchPokemonViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokeToPass = pc.pokemons[indexPath.row]
            destinationVC.pokemon = pokeToPass
            destinationVC.pc = pc
        }
    }
}
