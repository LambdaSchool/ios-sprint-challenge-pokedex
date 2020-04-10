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
    
    
    @IBOutlet weak var searchBarAction: UISearchBar!
    
    var newPokemon: Pokemon?
    private var pokemonController: PokemonController!
    var delegate: SearchDelegate?
    private var pokemonDetailVC: PokemonDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarAction.searchTextField.becomeFirstResponder()
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let pokemon = newPokemon else { return }
             delegate?.save(pokemon)
             navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let pokemon = newPokemon else { return }
        
        navigationItem.title = pokemon.name.capitalized
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "PokemonDetail", let pokemonDetailVC = segue.destination as? PokemonDetailViewController {
               pokemonDetailVC.pokemonController = pokemonController
               self.pokemonDetailVC = pokemonDetailVC
           }
       }
    
//    private func hideViews(_ hidden: Bool) {
//         saveButton.isHidden = hidden
//     }
    
    private func setImage() {
        guard let pokemon = newPokemon else { return }
        
        self.pokemonController?.fetchImage(at: pokemon.sprites) { result in
            guard let image = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.pokemonImageView.image = image
            }
        }
    }

}

extension PokemonSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }

        pokemonController.getPokemon(query) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.searchBarAction.searchTextField.resignFirstResponder()
                }
            case .failure(let networkError):
                print("network error: \(networkError)")
            }
        }
    }
}

