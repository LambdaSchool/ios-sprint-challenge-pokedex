//
//  PokemonListTableViewController.swift
//  Pokedex
//
//  Created by Isaac Lyons on 10/4/19.
//

import UIKit

class PokemonListTableViewController: UITableViewController {
    
    //MARK: Properties
    
    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemonController.pokemonList[indexPath.row]
        let name = pokemon.name.capitalizingFirstLetter()
        cell.textLabel?.text = name

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        pokemonController.move(from: fromIndexPath.row, to: to.row)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokemonDetailVC = segue.destination as? PokemonDetailViewController {
            if segue.identifier == "AddPokemonShowSegue" {
                pokemonDetailVC.pokemonController = pokemonController
            } else if segue.identifier == "PokemonDetailShowSegue",
                let indexPath = tableView.indexPathForSelectedRow {
                pokemonDetailVC.pokemon = pokemonController.pokemonList[indexPath.row]
            }
        }
    }

}
