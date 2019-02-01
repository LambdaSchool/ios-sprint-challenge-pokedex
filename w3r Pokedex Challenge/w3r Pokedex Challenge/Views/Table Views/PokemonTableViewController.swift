//
//  PokemonTableViewController.swift
//  w3r Pokedex Challenge
//
//  Created by Michael Flowers on 2/1/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pC = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pC.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pokemon = pC.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        // Configure the cell...

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let pokeToDelete = pC.pokemons[indexPath.row]
            pC.delete(pokemon: pokeToDelete)
            
            //delete from the view/reload tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController else { return }
            destinationVC.pC = pC
        } else if segue.identifier == "cellSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokeToPass = pC.pokemons[indexPath.row]
            destinationVC.pokemon = pokeToPass
        }
    }
 
}
