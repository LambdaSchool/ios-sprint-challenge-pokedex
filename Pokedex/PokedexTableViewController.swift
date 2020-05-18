//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Kenneth Jones on 5/17/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    var buttonHidden = true
    var searchBarHidden = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonController.pokemon[indexPath.row].name.capitalizingFirstLetter()

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? PokemonViewController {
                searchVC.pokemonController = pokemonController
                searchVC.searchBarHidden = !searchBarHidden
                searchVC.buttonHidden = buttonHidden
            }
        } else if segue.identifier == "DetailSegue" {
            if let detailVC = segue.destination as? PokemonViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailVC.pokemonController = pokemonController
                    detailVC.pokemon = pokemonController.pokemon[indexPath.row]
                    detailVC.searchBarHidden = searchBarHidden
                    detailVC.buttonHidden = buttonHidden
                }
            }
        }
    }
}

// Sourced from Hacking With Swift
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
