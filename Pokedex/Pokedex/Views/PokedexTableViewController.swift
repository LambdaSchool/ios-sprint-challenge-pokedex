//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Angel Buenrostro on 1/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokemonController()
    var pokes : [Pokemon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonController.searchPokemon(searchTerm: "25") { (error) in
            if let error = error {
                print(error)
            }
            let pokemon = self.pokemonController.pokemon
            let newPoke = self.pokemonController.createPokemon(name: (pokemon?.name)!, id: (pokemon?.id)!, abilities: (pokemon?.abilities)!, types: (pokemon?.types)!, sprites: (pokemon?.sprites)! as! Dictionary<String, URL>)
            self.pokes.append(newPoke)
            DispatchQueue.main.async {
                print("Pokemon data returned: \(self.pokemonController.pokemon)")
                print("Number of pokemon in pokes : \(self.pokemonController.pokes.count)")
                print(self.pokes)
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchSegue" {
            let destinationVC = segue.destination as! PokemonSearchViewController
            destinationVC.pokemonController = pokemonController
            
        }
        
        if segue.identifier == "pokemonSegue" {
            let cell = sender as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let pokemon = pokemonController.pokes[indexPath.row]
            let destinationVC = segue.destination as! PokemonSearchViewController
            destinationVC.pokemonController = pokemonController
            destinationVC.pokemon = pokemon
            
            
        }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
  
    
}
