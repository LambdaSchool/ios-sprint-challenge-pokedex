//
//  PokemonListTableViewContorller.swift
//  Sprint3
//
//  Created by Victor  on 5/10/19.
//  Copyright © 2019 com.Victor. All rights reserved.
//

import Foundation
import UIKit

class PokemonListTableViewContorller: UITableViewController {
    
    let pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "search", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            guard let searchVC = segue.destination as? PokemonSearchViewController
                else { return }
            searchVC.pokemonController = pokemonController
            pokemonController.pokemon = nil
        } else if segue.identifier == "detail" {
            guard let searchVC = segue.destination as? PokemonSearchViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            pokemonController.pokemon = pokemonController.pokemons[indexPath.row]
            searchVC.pokemonController = pokemonController
        }
    }
    
}
