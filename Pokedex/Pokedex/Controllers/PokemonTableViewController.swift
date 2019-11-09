//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Alex Thompson on 11/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    var pokemon: Pokemon! {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemonMonster = pokemonController.pokemonList[indexPath.row]
        cell.textLabel?.text = pokemonMonster.name

        return cell
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetail" {
            guard let pokemonVC = segue.destination as? PokemonSearchViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            pokemonVC.pokemonController = pokemonController
            pokemonVC.pokemon = pokemonController.pokemonList[indexPath.row]
            print("Detail segue hit")
        } else if segue.identifier == "PokemonSearch" {
            if let searchVC = segue.destination as? PokemonSearchViewController {
                searchVC.pokemonController = pokemonController
            }
        }
    }
}
