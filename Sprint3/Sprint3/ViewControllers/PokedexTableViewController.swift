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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.pokemonLabel?.text = pokemon.name
        let spriteURL = pokemon.sprite.frontDefault
        guard let spriteData = try? Data(contentsOf: spriteURL) else { return cell }
        cell.pokemonSprite.image = UIImage(data: spriteData)



        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            pokemonController.deletePokemon(pokemonIndex: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
