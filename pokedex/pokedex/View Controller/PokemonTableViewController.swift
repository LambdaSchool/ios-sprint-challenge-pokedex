//
//  PokemonTableViewController.swift
//  pokedex
//
//  Created by Sammy Alvarado on 5/17/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let reuseIdentifier = "PokemonCell"
    let apiController = APIController()
    
    private var pokemonName: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let pokemon = apiController.searchResults[indexPath.row]
        
        
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else {fatalError()}

        // Configure the cell...
        cell.imageView?.image = UIImage(data: pokemonImageData)
        cell.textLabel?.text = pokemon.name.capitalized
        
        

        return cell
    }
    
    // Allow you to send the data into
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemonSegue" {
            guard let searchVC = segue.destination as? PokemonSearchViewController else {return}
            searchVC.apiController = apiController
        } else if segue.identifier == "ShowPokemonSegue"{
            guard let detailVC = segue.destination as? PokemonDetailViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let pokemon = apiController.searchResults[indexPath.row]
            detailVC.pokemon = pokemon
        }
    }


}
