//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_259 on 3/13/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    // MARK: - Properties
    let pokeController = PokeController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokeController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        let pokemon = pokeController.pokemons[indexPath.row]
        
        cell.textLabel?.text = pokemon.name
        

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokeSegue" {
            guard let searchVC = segue.destination as? PokeDetailsViewController else { return }
            searchVC.pokeController = pokeController
        } else if segue.identifier == "PokeDetailSegue" {
            guard let pokeDetailVC = segue.destination as? PokeDetailsViewController else { return }
            pokeDetailVC.pokeController = pokeController
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            pokeDetailVC.pokemon = pokeController.pokemons[index]
        }
    }

}

