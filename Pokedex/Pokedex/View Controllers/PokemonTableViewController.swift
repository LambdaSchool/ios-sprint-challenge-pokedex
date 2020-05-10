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
    
    var pokemon: Pokemon! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //TODO - VIEW WILL APPEAR FUNC
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return pokemonController.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemonName = pokemonController.pokemonArray[indexPath.row]
        cell.detailTextLabel?.text = pokemonName.name
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemonController.pokemonArray[indexPath.row]
        } else if segue.identifier == "SearchSegue" {
            if let searchSegue = segue.destination as? PokemonDetailViewController {
                searchSegue.pokemonController = pokemonController
            }
        }
    }
}
