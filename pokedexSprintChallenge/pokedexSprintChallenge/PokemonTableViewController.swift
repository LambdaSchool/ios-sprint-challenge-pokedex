//
//  PokemonTableViewController.swift
//  pokedexSprintChallenge
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemon.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonController.pokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name
        guard let imageData = try? Data(contentsOf: pokemon.image.sprites) else { fatalError() }
        cell.imageView?.image = UIImage(data: imageData)

        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokedexDetailViewSegue" {
            guard let pokemonDetailVC = segue.destination as? PokemonDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokemon[indexPath.row]
            pokemonDetailVC.pokemon = pokemon
        } 
    }
 

}
