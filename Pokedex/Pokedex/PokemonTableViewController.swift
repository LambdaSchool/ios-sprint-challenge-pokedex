//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 1/1/19.
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
        return PokemonModel.shared.numberOfPokemon
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedPokemonTableViewCell.reuseIdentifier, for: indexPath) as? SavedPokemonTableViewCell else {fatalError()}
    
    let pokemon = PokemonModel.shared.pokemon(at: indexPath)
    cell.pokemonNameLabel.text = pokemon.name
        guard let imageURL = URL(string: pokemon.sprites.frontDefault), let imageData = try? Data(contentsOf: imageURL) else { return cell }
        cell.spriteImageView.image = UIImage(data: imageData)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PokemonModel.shared.deletePokemon(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else { return }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let PokemonVC = segue.destination as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        let pokemon = PokemonModel.shared.pokemon(at: indexPath)
        PokemonVC.pokemon = pokemon
    }
    

}
