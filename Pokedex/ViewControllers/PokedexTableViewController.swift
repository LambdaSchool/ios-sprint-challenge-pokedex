//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Chris Price on 3/21/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        print("viewDidLoad was called.")
        super.viewDidLoad()
        title = "Pokedex"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear was called.")
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)  as? PokedexTableViewCell else { return UITableViewCell() } 
    
        let pokemon = pokemonController.pokemonArray[indexPath.row]
        cell.pokemon = pokemon
        print(pokemon.image!)
        cell.pokemonController = pokemonController

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemonArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        // From Paul Hudson at https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearch" {
            guard let destinationVC = segue.destination as? SearchViewController else { return }
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ToDetail" {
            guard let destinationVC = segue.destination as? DetailViewController,
                let index = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokemonArray[index.row]
            destinationVC.pokemon = pokemon
            destinationVC.pokemonController = pokemonController
        }
    }
}
