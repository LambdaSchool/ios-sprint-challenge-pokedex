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
    var model : Model = Model()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func editButtonTapped(_ sender: Any) {
        tableView.setEditing(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(stopEditingTable(_:)))
    }
    @objc func stopEditingTable(_ sender: Any) {
        tableView.setEditing(false, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.savedPokemon.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PokemonTableViewCell
        cell.textLabel?.text = model.savedPokemon[indexPath.row].name
        cell.pokemon = model.savedPokemon[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            model.savedPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "CellTapped":
            let newSender = sender as! PokemonTableViewCell
            let indexPath = tableView.indexPath(for: newSender)
            let destination = segue.destination as! PokemonDetailViewController
            destination.pokemon = model.savedPokemon[indexPath!.row]
        case "SearchTapped":
            let destination = segue.destination as! PokemonDetailViewController
            destination.model = self.model
        default:
            print("Unkown Segue")
        }
    }
}
