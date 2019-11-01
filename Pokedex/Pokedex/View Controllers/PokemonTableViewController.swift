//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    // MARK: - Properties
    
    var pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.savedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }

        cell.pokemon?.name = pokemonController.savedPokemon[indexPath.row].name

        return cell
    }








    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
