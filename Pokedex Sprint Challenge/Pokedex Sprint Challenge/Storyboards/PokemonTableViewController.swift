//
//  PokemonTableViewController.swift
//  Pokedex Sprint Challenge
//
//  Created by Mark Poggi on 4/10/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let searchPokemonController = SearchPokemonController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchPokemonController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = searchPokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let destination = segue.destination as? SearchViewController else {return}
            destination.searchPokemonController = searchPokemonController
            
        } else {
            if segue.identifier == "DetailSegue" {
                guard let destinationVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow  else { return }
                let pokemon = searchPokemonController.pokemons[indexPath.row]
                destinationVC.searchPokemonController = searchPokemonController
            }
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "SearchSegue", sender: self)
        
    }
    
}
