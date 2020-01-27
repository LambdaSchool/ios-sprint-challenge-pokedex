//
//  SavedPokemonViewController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 27/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class SavedPokemonViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var closeViewButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var pokemonApiController: PokemonAPIController?
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    //MARK: Naviagtion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavedPokemonShowDetailSegue" {
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            detailVC.pokemonApiController = pokemonApiController
            detailVC.pokemon = pokemonApiController?.savedPokemon[indexPath.row]
            detailVC.saveButtonShouldShow = false
        }
    }

    //MARK: IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SavedPokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let savedPokemon = pokemonApiController?.savedPokemon else { return 0 }
        return savedPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        
        guard let pokemon = pokemonApiController?.savedPokemon[indexPath.row] else { return UITableViewCell() }
        
        cell.pokemonNameLabel.text = "#\(pokemon.id): \(pokemon.name.capitalized)"
        cell.pokemonTypeLabel.text = pokemon.formatPokemonTypes()
        
        pokemonApiController?.getPokemonSprite(with: pokemon.sprites.front_default) { (image, error) in
            guard error == nil else {
                print("Error retrieving sprite image for Pokemon: \(String(describing: error))")
                return
            }
            
            guard let image = image else {
                print("Error with image file: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                cell.pokemonImageView.image = image
            }
            
        }
        
        return cell
    }

}

extension SavedPokemonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonApiController?.savedPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
