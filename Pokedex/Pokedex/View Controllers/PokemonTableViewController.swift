//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Nonye on 5/8/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit


class PokemonTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
=======
>>>>>>> parent of f5d1f1e... So close to being done
    }
    
    //TODO - VIEW WILL APPEAR FUNC
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD

        return pokemonController.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemonName = pokemonController.pokemonArray[indexPath.row]
        cell.detailTextLabel?.text = pokemonName.name
        
        return cell
    }
=======
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
>>>>>>> parent of f5d1f1e... So close to being done
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemonController.pokemonArray[indexPath.row]
<<<<<<< HEAD
        } else if segue.identifier == "SearchSegue" {
=======
            print("DetailViewSegue hit")
            
        }else if segue.identifier == "SearchSegue" {
>>>>>>> parent of f5d1f1e... So close to being done
            if let searchSegue = segue.destination as? PokemonDetailViewController {
                searchSegue.pokemonController = pokemonController
            }
        }
    }
    
    
}
