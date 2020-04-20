//
//  PokedexTableViewController.swift
//  Pokédex
//
//  Created by Thomas Sabino-Benowitz on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokemonAPI: PokemonController = PokemonController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokédex"
        print("\(pokemonAPI.pokemonList.count)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(pokemonAPI.pokemonList.count)")
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonAPI.pokemonList.count
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)

        cell.textLabel?.text = pokemonAPI.pokemonList[indexPath.row].name.capitalized

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        
        pokemonAPI.pokemonList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        }

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            if let DetailVC = segue.destination as? PokeDetailViewController {
                DetailVC.pokemonAPI = self.pokemonAPI
                DetailVC.title = "Search"
            }
        }
        if segue.identifier == "ShowPokemonDetailSegue" {
            if let DetailVC = segue.destination as? PokeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                DetailVC.title = "Who's That Pokémon?"
                DetailVC.pokemonAPI = self.pokemonAPI
                DetailVC.pokemonAPI?.pokemon = pokemonAPI.pokemonList[indexPath.row]
//                DetailVC.nameLabel.text = pokemonAPI.pokemonList[indexPath.row].name
//                DetailVC.idLabel.text = "\(pokemonAPI.pokemonList[indexPath.row].id)"
            }
        }
    }
    
}
