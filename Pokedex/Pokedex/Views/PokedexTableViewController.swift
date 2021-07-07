//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Angel Buenrostro on 1/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokemonController = PokemonController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("Name of pokemon in PokedexVC pokes: \(self.pokemonController.pokes.count)")
        DispatchQueue.main.async {
            
            if let pokeArray = UserDefaults.standard.object(forKey: "pokemon"){
                let decoder = JSONDecoder()
                if let loadedPokemon = try? decoder.decode(PokemonController.self, from: pokeArray as! Data) {
                    print(loadedPokemon)
                    self.pokemonController = loadedPokemon
                }
            }
            
            
            
            
            self.tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
       
        // Do any additional setup after loading the view.
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.pokemonController.pokes.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "pokemoncell", for: indexPath)
     let pokemon = pokemonController.pokes[indexPath.row]
        print("Inside tableViewCell cell for row method: \(pokemon.name)")
     cell.textLabel!.text = pokemon.name
     
     return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        
        
        self.pokemonController.pokes.remove(at: indexPath.row)
     // Delete the row from the data source
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.removeObject(forKey: "<#T##String#>")
            self.tableView.reloadData()
            print("New number of pokemon: \(self.pokemonController.pokes.count)")
        }
     }
     }
    
    
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
            destinationVC.pokemonController = self.pokemonController
            
        }
        
        if segue.identifier == "pokemonSegue" {
            let cell = sender as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let pokemon = self.pokemonController.pokes[indexPath.row]
            let destinationVC = segue.destination as! PokemonSearchViewController
            destinationVC.pokemonController = self.pokemonController
            destinationVC.pokemon = pokemon
            
            
        }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
  
    
}
