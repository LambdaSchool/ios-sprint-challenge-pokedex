//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Michael on 1/17/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()

    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonController.savedPokemon.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let selectedPokemon = pokemonController.savedPokemon[indexPath.row]
        guard let imageURL = URL(string: selectedPokemon.sprites.frontShiny), let imageData = try? Data(contentsOf: imageURL) else { return UITableViewCell() }
        
        
        cell.imageView?.image = UIImage(data: imageData)
        cell.textLabel?.text = selectedPokemon.name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pokemonToDelete = pokemonController.savedPokemon[indexPath.row]
        if editingStyle == .delete {
            pokemonController.deletePokemon(pokemon: pokemonToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            guard let searchDetailVC = segue.destination as? PokemonDetailViewController else { return }
            searchDetailVC.pokemonController = pokemonController
        } else if segue.identifier == "PokemonDetailSegue" {
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            pokemonDetailVC.pokemonController = pokemonController
            pokemonDetailVC.pokemon = pokemonController.savedPokemon[indexPath.row]
        }
    }
}
