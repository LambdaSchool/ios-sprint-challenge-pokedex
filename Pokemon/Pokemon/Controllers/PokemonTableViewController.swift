//
//  PokemonTableVC.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
  
  var apiController = NetworkingService()
  var searching = false
  var filteredPokemons = [Pokemon]()
  
  @IBOutlet weak var pokemonSearchBar: UISearchBar! {   didSet {  pokemonSearchBar.delegate = self  }   }
  
  //MARK: - View Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
    setUpNavBar()
    setUpToolBar()
   
  }
  
  
  private func setUpNavBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.isToolbarHidden = false
  }
  
  private func setUpToolBar() {
    let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    toolbarItems = [flexSpace,sortButton]
  }
  
  @objc func sortTapped() {
    let ac = UIAlertController(title: "Sort Pokemon", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "Sort name alphabetically", style: .default, handler: sortName(action:)))
    ac.addAction(UIAlertAction(title: "Sort by ID", style: .default, handler: sortID(action:)))
    ac.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    present(ac, animated: true, completion: nil)
  }
  
  private func sortID(action:UIAlertAction) {
    apiController.sortId()
    tableView.reloadData()
  }
  
  private func sortName(action: UIAlertAction) {
    apiController.sortAlphabetically()
    tableView.reloadData()
  }
  
  // MARK: - Table View Data Source
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searching ? filteredPokemons.count : apiController.pokemons.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Helper.cellID, for: indexPath)
    
    cell.textLabel?.text =  updatePokemonForCell(isSearching: searching, at: indexPath).name.capitalizingFirstLetter()
    cell.detailTextLabel?.text = "ID: \(updatePokemonForCell(isSearching: searching, at: indexPath).id)"
    
    return cell
  }
  
  //MARK:- Helper
  private func updatePokemonForCell(isSearching: Bool,at indexPath: IndexPath) -> Pokemon {
    let pokemon: Pokemon
    pokemon =  isSearching ? filteredPokemons[indexPath.row] : apiController.pokemons[indexPath.row]
    return pokemon
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if searching {
        let pokemon = filteredPokemons[indexPath.row]
        guard let index = filteredPokemons.firstIndex(of: pokemon) else { return }
        filteredPokemons.remove(at: index)
        apiController.deletePokemon(with: pokemon)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
        
      } else {
        let pokemon = apiController.pokemons[indexPath.row]
        apiController.deletePokemon(with: pokemon)
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
  }
  
  // MARK: - Segue
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Helper.segueID {
      if let destVC = segue.destination as? PokemonDetailViewController {
        destVC.apiController = apiController
      }
    } else if segue.identifier == Helper.cellSegue {
      if let destVC = segue.destination as? PokemonDetailViewController {
        guard let index = tableView.indexPathForSelectedRow else { return }
        if searching {
          destVC.pokemon = filteredPokemons[index.row]
          destVC.apiController = apiController
          
        } else {
          destVC.pokemon = apiController.pokemons[index.row]
          destVC.apiController = apiController
          
        }
      }
    }
  }
}
