//
//  PokedexTableViewController.swift
//  Sprint3
//
//  Created by Kobe McKee on 5/17/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    let pokemonController = PokemonController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.pokemonLabel?.text = pokemon.name.capitalized
        guard let url = URL(string: pokemon.sprites.frontDefault),
            let pokemonImageData = try? Data(contentsOf: url) else { return UITableViewCell() }
        cell.pokemonSprite.image = UIImage(data: pokemonImageData)


        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            pokemonController.deletePokemon(pokemonIndex: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let destinationVC = segue.destination as? PokemonSearchViewController else { return }
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "PokemonDetailSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let pokemonIndex = tableView.indexPathForSelectedRow else { return }
            let pokemon = pokemonController.pokemons[pokemonIndex.row]
            destinationVC.pokemon = pokemon
        }
    }

}
