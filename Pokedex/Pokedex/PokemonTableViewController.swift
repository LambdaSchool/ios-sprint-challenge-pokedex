//
//  ViewController.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 1/25/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonController.shared.numberOfPokemon
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedPokemonTableViewCell.reuseIdentifier, for: indexPath) as? SavedPokemonTableViewCell else { fatalError("Unable to dequeue cell")}
        
        let pokemon = PokemonController.shared.pokemon(at: indexPath)
        cell.pokemonNameLabel.text = pokemon.name
        guard let url = URL(string: pokemon.sprites.frontDefault),
           let data = try? Data(contentsOf: url) else { return cell }
        cell.spriteImageView.image = UIImage(data: data)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PokemonController.shared.deletePokemon(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else { return }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pokemonVC = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        let pokemon = PokemonController.shared.pokemon(at: indexPath)
        pokemonVC.pokemon = pokemon
    }
    
}

