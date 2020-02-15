//
//  PokemonTableVC.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class PokemonTableVC: UITableViewController {
    
    var apiController = APIController()
    private var totalPokeNames = [String]()
    var searching = false
    var filteredPokemons = [Pokemon]()
    
   @IBOutlet weak var pokemonSearchBar: UISearchBar! {
          didSet {
              pokemonSearchBar.delegate = self
              
          }
      }
    

 
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpNavBar()
        setUpToolBar()
        apiController.fetchAllNames { (names) in
            do {
                let results = try names.get()
                for pokemon in results.results {
                    self.totalPokeNames.append(pokemon.name.capitalizingFirstLetter())
                }
            } catch let err {
                print("\(err.localizedDescription)")
            }
        }
  
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
        if searching {
            return filteredPokemons.count
        } else {
            return apiController.pokemons.count
        }
 
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Helper.cellID, for: indexPath)
        if searching {
            cell.textLabel?.text = filteredPokemons[indexPath.row].name.capitalizingFirstLetter()
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            cell.detailTextLabel?.text = "ID:\(filteredPokemons[indexPath.row].id)"
            
        } else {
            cell.textLabel?.text = apiController.pokemons[indexPath.row].name.capitalizingFirstLetter()
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            cell.detailTextLabel?.text = "ID:\(apiController.pokemons[indexPath.row].id)"
        }
        
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if searching {
                let pokemon = filteredPokemons[indexPath.row]
                guard let index = filteredPokemons.firstIndex(of: pokemon) else { return }
                filteredPokemons.remove(at: index)
                apiController.pokemons.remove(at: index)
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
            if let destVC = segue.destination as? PokemonDetailVC {
                destVC.delegate = self
            }
        } else if segue.identifier == Helper.cellSegue {
            if let destVC = segue.destination as? PokemonDetailVC {
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

// MARK: - Extension
extension PokemonTableVC: PokemonDetailVCDelegate {
    func didReceivePokemon(with pokemon: Pokemon) {
        apiController.pokemons.append(pokemon)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    
}

