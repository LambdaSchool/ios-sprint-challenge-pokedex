//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Cora Jacobson on 7/18/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        if let pokemon = pokemon {
            self.updateViews(with: pokemon)
            searchBar.isHidden = true
        }
    }
    
    func updateViews(with pokemon: Pokemon) {
        title = pokemon.name.capitalized
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Types: \(pokemon.types.joined(separator: ", "))"
        abilityLabel.text = "Abilities: \(pokemon.abilities.joined(separator: ", "))"
        guard let pokemonController = pokemonController else { return }
        pokemonController.fetchImage(at: pokemon.imageString) { (result) in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    @IBAction func SaveButton(_ sender: UIButton) {
        if let pokemonController = pokemonController,
            let pokemon = pokemon {
            pokemonController.pokemonArray.append(pokemon)
            pokemonController.saveToPersistentStore()
            navigationController?.popViewController(animated: true)
        }
    }
    
}

extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        guard let pokemonController = pokemonController else { return }
        pokemonController.getPokemon(searchTerm) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                    self.searchBar.isHidden = true
                    self.pokemon = pokemon
                }
            case .failure(let error):
                print("Error fetching pokemon details: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "There was an error.", message: "Please check your search term and try again.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
