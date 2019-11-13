//
//  PokedexTableViewController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/13/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemonArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        let pokemonCharacter = pokemonController.pokemonArray[indexPath.row]
        cell.textLabel?.text = pokemonCharacter.name
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            
            detailVC.pokemonController = pokemonController
            detailVC.pokemon = pokemonController.pokemonArray[indexPath.row]
            
            
        } else if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? PokemonDetailViewController {
                searchVC.pokemonController = pokemonController
            }
        }
    }
}
