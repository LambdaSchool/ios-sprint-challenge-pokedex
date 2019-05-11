//
//  PokemonTableViewController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/10/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemonController.pokemons[indexPath.row]

        cell.textLabel?.text = pokemon.name

        return cell
    }





    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source

            let pokemon = pokemonController.pokemons[indexPath.row]
            pokemonController.delete(pokemon: pokemon)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }





    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SearchSegue" {

            guard let SearchVC = segue.destination as? SearchViewController else { return }

            SearchVC.pokemonController = pokemonController

            //SearchVC.pokemon = pokemonController
            
        } else if segue.identifier == "DetailSegue" {
            guard let DetailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            DetailVC.pokemon = pokemonController.pokemons[indexPath.row]
            

        }
    }
}
