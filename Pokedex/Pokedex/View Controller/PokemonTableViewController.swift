//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Fabiola S on 9/13/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
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


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearchSegue" {
            let destinationVC = segue.destination as! PokemonDetailViewController
            destinationVC.pokemonController = pokemonController
            
        } else if segue.identifier == "PokemonDetailSegue" {
           guard let detailVC = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
                    let pokemon  = pokemonController.pokedex[indexPath.row]
            
                detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemon
            }
        }

}
