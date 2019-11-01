//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    var pokemonController: PokemonController?
    
    var pokemon: Pokemon?
    
    var searching: Bool?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    func updateViews() {
        if let searching = searching {
            searchBar.isHidden = !searching
        }
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name
            pokemonIDLabel.text = "\(pokemon.id)"
            pokemonTypesLabel.text = pokemon.types.joined(separator: ", ")
            pokemonAbilitiesLabel.text = pokemon.abilities.joined(separator: ", ")
            showPokemonDetailLabels(true)
            
            fetchImage()
        } else {
            showPokemonDetailLabels(false)
        }
    }

    func showPokemonDetailLabels(_ shouldShow: Bool) {
        nameLabel.isHidden = !shouldShow
        imageView.isHidden = !shouldShow
        pokemonIDLabel.isHidden = !shouldShow
        pokemonTypesLabel.isHidden = !shouldShow
        pokemonAbilitiesLabel.isHidden = !shouldShow
        
        idLabel.isHidden = !shouldShow
        typesLabel.isHidden = !shouldShow
        abilitiesLabel.isHidden = !shouldShow
    }
    
    private func search() {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
            else { return }
        searchBar.resignFirstResponder()
        
        pokemonController?.performSearch(for: searchTerm, completion: { result in
            do {
                let pokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }
                self.fetchImage()
            } catch {
                if let error = error as? NetworkError {
                    print(error.rawValue)
                }
            }
        })
    }
    
    private func fetchImage() {
        guard let pokemon = pokemon else { return }
        self.pokemonController?.fetchImage(at: pokemon.imageURL, completion: { result in
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.updateViews()
                }
            } catch {
                if let error = error as? NetworkError {
                    print(error.rawValue)
                }
            }
        })
    }
}

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }
}
