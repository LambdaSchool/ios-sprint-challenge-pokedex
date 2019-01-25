//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Cameron Dunn on 1/25/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import UIKit

class PokemonTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var model : Model?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.savedPokemon.count ?? 0
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PokemonTableViewCell
        cell.textLabel?.text = model?.savedPokemon[indexPath.row].name
        cell.pokemon = model?.savedPokemon[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "CellTapped":
            let newSender = sender as! PokemonTableViewCell
            let indexPath = tableView.indexPath(for: newSender)
            let destination = segue.destination as! PokemonDetailViewController
            destination.searchedPokemon = model?.savedPokemon[indexPath!.row]
        default:
            print("Unkown Segue")
        }
    }
}
