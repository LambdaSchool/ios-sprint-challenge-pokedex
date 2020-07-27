//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 20/07/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    //MARK: - Properties
    let pokemonController = PokemonController()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.capturedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell()}

        let index = indexPath.row
        let pokemon = pokemonController.capturedPokemon[index]
        
        cell.pokemonNameLabel.text = pokemon.name.capitalized
        
        var typesLabelText: String = ""
        for type in pokemon.types {
            typesLabelText.append(contentsOf: type.type.name)
        }
        
        pokemonController.getSprite(from: pokemon.sprites.front_default) { (image) in
            guard let image = image else {
                print("Error retrieving Sprite from server.")
                return
            }
            
            DispatchQueue.main.async {
                cell.spriteImageView.image = image
            }
        }

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            pokemonController.capturedPokemon.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSearchShowSegue" {
            if let destinationVC = segue.destination as? PokemonViewController {
                destinationVC.pokemonController = pokemonController
                destinationVC.title = "Search"
                destinationVC.pokedexViewType = .search
            }
        } else {
            if let destinationVC = segue.destination as? PokemonViewController {
                destinationVC.pokemonController = pokemonController
                destinationVC.title = "Captured"
                destinationVC.pokedexViewType = .saved
                destinationVC.pokemonIndex = tableView.indexPathForSelectedRow?.row
            }
        }
    }

}
