//
//  PokemonTableVC.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class PokemonTableVC: UITableViewController {
     var pokemons = [Pokemon]()
  
    var apiController = APIController()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

  
    
    // MARK: - Table View Data Source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Helper.cellID, for: indexPath)
        cell.textLabel?.text = pokemons[indexPath.row].name.capitalizingFirstLetter()
        return cell
    }
    
    
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Helper.segueID {
            if let destVC = segue.destination as? PokemonDetailVC {
                destVC.delegate = self
            }
        } else if segue.identifier == Helper.cellSegue {
            if let destVC = segue.destination as? PokemonDetailVC {
                guard let index = tableView.indexPathForSelectedRow else { return }
                destVC.pokemon = pokemons[index.row]
                destVC.apiController = apiController
            }
        }
    }
    
    
}


extension PokemonTableVC: PokemonDetailVCDelegate {
    func didReceivePokemon(with pokemon: Pokemon) {
        pokemons.append(pokemon)
        tableView.reloadData()
    }
    
   
    
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
