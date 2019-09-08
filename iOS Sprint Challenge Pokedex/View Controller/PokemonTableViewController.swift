//
//  PokemonTableViewController.swift
//  iOS Sprint Challenge Pokedex
//
//  Created by Andrew Ruiz on 9/6/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonTeam.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokemonTeam[indexPath.row]
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else { fatalError() }
        cell.imageView?.image = UIImage(data: pokemonImageData)
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchPokemon" {
            guard let searchVC = segue.destination as? PokemonSearchViewController else { return }
            searchVC.pokemonController = pokemonController
        }
    }
}
