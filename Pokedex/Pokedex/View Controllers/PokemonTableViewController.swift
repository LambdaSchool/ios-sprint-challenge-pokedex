//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Nonye on 5/8/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(pokemonController.pokemonArray.count)
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonController.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonCell ?? PokemonCell()
        
        let pokemonName = pokemonController.pokemonArray[indexPath.row]
        cell.pokemonLabelName.text = pokemonName.name
        print(pokemonName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemonController.pokemonArray[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: pokemon)
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            
            if let detailVC = segue.destination as? PokemonDetailViewController
            {
                if let pokemon = sender as? Pokemon
                {
                    detailVC.pokemonController = pokemonController
                    detailVC.pokemon = pokemon
                    
                }
                
            }
        }
        else if segue.identifier == "SearchSegue" {
            if let searchSegue = segue.destination as? PokemonDetailViewController {
                searchSegue.pokemonController = pokemonController
            }
        }
    }
}

