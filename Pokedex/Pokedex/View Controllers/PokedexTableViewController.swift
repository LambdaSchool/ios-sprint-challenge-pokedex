//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Kelson Hartle on 5/8/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
        
        print(pokemonController.pokemonArray.count)
    }
    
    //MARK: - Properties
    let pokemonController = PokemonController()

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)

        let pokemonsToBeDisplayed = pokemonController.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemonsToBeDisplayed.name

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPokemonSegue" {
            guard let searchVC = segue.destination as? SearchAddPokemonViewController else { return }
            
            searchVC.pokemonController = pokemonController
        }
        
        else if segue.identifier == "detailViewSegue" {
            
            guard let detailVC = segue.destination as? PokemonDetailViewController else { return }
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                detailVC.pokemonController = pokemonController
                detailVC.pokemon = pokemonController.pokemonArray[indexPath.row]
            }
        }
    }
}
