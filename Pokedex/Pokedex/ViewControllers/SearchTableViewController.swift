//
//  SearchTableViewController.swift
//  Pokedex
//
//  Created by Benjamin Hakes on 12/7/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import UIKit
import Foundation

class SearchTableViewController: UITableViewController, UISearchBarDelegate{

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        searchBar.delegate = self
        // TODO: Update updatehandler
        Model.shared.updateHandler = { self.tableView.reloadData() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.delegate = self
        // TODO: Update updatehandler
        Model.shared.updateHandler = { self.tableView.reloadData() }
    }

//    // TODO: Update deinit
//    deinit {
//        Model.shared.updateHandler = nil
//    }
    
    // TODO: Update search button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        Model.shared.search(for: searchTerm){
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Model.shared.numberOfResults()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else {fatalError("Unable to retrieve and cast cell")}
        
        // Configure the cell...
        let pokemon = Model.shared.result(at: indexPath.row)
        
        // fill out the cell labels
        cell.nameLabel.text = pokemon.name
        cell.idLabel.text = String(pokemon.id)
        
        var abilitiesString = "Abilities: "
        for each in 0..<(pokemon.abilities.count - 1){
            abilitiesString += "\(pokemon.abilities[each].ability.name), "
        }
        abilitiesString += pokemon.abilities[pokemon.abilities.count - 1].ability.name
        
        cell.abilitiesLabel.text = abilitiesString
        
        var typesString = "Types: "
        for each in 0..<(pokemon.types.count - 1){
            typesString += "\(pokemon.types[each].type.name), "
        }
        typesString += pokemon.types[pokemon.types.count - 1].type.name
        
        cell.typesLabel.text = typesString
        
        let imageUrlString = pokemon.sprites.frontDefault

        DispatchQueue.global(qos: .background).async {
            do
            {
                let data = try Data.init(contentsOf: URL.init(string:imageUrlString)!)
                DispatchQueue.main.async {
                    let image: UIImage = UIImage(data: data)!
                    cell.pokemonImageView.image = image
                }
            }
            catch {
                // error
                fatalError("unable to get Pokemon picture")
            }
        }
        
        cell.onComplete = { self.navigationController?.popViewController(animated: true) }
        
        //cell.typesLabel.text = pokemon.types[0] // TODO: fix this
        //cell.abilitiesLabel.text = pokemon.abilities[0] // TODO: fix this
        
        return cell
    }
    
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
