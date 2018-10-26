//
//  PokedexTVC.swift
//  Pokedex
//
//  Created by Nikita Thomas on 10/26/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class PokedexTVC: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.savedPokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedCell
        let pokemon = Model.shared.savedPokemon[indexPath.row]
        
        cell.nameLabel.text = pokemon.name
        ImageLoader.fetchImage(from: URL(string: "\(pokemon.sprites.frontDefault)")) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                cell.spriteImage.image = image
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            Model.shared.savedPokemon.remove(at: indexPath.row)
        }
    }
    
    
}
