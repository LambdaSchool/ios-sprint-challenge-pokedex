//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by Bhawnish Kumar on 4/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit

protocol SearchDelegate {
    func save(_ pokemon: Pokemon)
}
class PokemonSearchViewController: UIViewController {

    
    @IBOutlet weak var pokemonContainerView: UIView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    var newPokemon: Pokemon?
    var pokemonController: PokemonController!
    var delegate: SearchDelegate?
    private var pokemonDetailVC: PokemonDetailViewController?
    private let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        
    }
    
    private func setupSearchController() {
         navigationItem.searchController = searchController
         searchController.searchBar.delegate = self
     }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemonDetailVC?.pokemon else { return }
             delegate?.save(pokemon)
             navigationController?.popViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "PokemonDetail", let pokemonDetailVC = segue.destination as? PokemonDetailViewController {
               pokemonDetailVC.pokemonController = pokemonController
               self.pokemonDetailVC = pokemonDetailVC
           }
       }
    
    private func hideViews(_ hidden: Bool) {
         saveButton.isHidden = hidden
     }
    
   

}

extension PokemonSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }

        pokemonController.getPokemon(query) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                   self.pokemonDetailVC?.pokemon = pokemon
                   self.title = pokemon.name.capitalized
                   self.saveButton.isEnabled = true
                    self.searchController.dismiss(animated: true)
                }
            case .failure(let networkError):
                print("network error: \(networkError)")
            }
        }
    }
}

