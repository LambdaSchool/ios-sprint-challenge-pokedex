//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/2/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    
    let pokemonController = PokemonController()
//     let customButton = UIButton(type: .custom)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        customButton.setImage(UIImage(named: "pokedex"), for: .normal)
//        customButton.frame = CGRect(x: 100.0, y: 0.0, width: 20.0, height: 30.0)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customButton)
         tableView.reloadData()
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print(self.customButton.convert(self.customButton.frame, to: nil))
//    }

    // MARK: - Table view data source
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonList.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as! PokedexTableViewCell
        let pokemon = pokemonController.pokemonList[indexPath.row]
        
        cell.pokeNameLabel.text = pokemon.name.capitalized
        
        guard let url = URL(string: pokemon.sprites.front_default),
            let pokemonImageData = try? Data(contentsOf: url) else { return UITableViewCell() }
        cell.spriteView.image = UIImage(data: pokemonImageData)
        return cell
    }
   

    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            pokemonController.deletePokemon(pokemonIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
      
    }
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SearchSegue" {
            guard let destinationVC = segue.destination as? PokemonSearchViewController else {return}
            destinationVC.pokemonController = pokemonController
        } else if segue.identifier == "ShowDetailSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let pokemonIndex = tableView.indexPathForSelectedRow else {return}
             let pokemon = pokemonController.pokemonList[pokemonIndex.row]
            destinationVC.pokemon = pokemon
        }
        
    }
}



