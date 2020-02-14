//
//  TableViewController.swift
//  PokeDex
//
//  Created by Joseph Rogers on 11/10/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    // MARK: Properties
    let pokemonController = PokemonController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokedex[indexPath.row]
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = "\(pokemon.id)"
        if let imageData = pokemon.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearchSegue" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.pokemonController = pokemonController
            
        } else if segue.identifier == "PokemonDetailSegue" {
           guard let detailVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
                    let pokemon  = pokemonController.pokedex[indexPath.row]
            
                detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemon
            }
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            pokemonController.pokedex.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }

}
