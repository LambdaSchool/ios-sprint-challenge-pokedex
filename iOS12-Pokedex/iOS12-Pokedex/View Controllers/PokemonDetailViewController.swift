//
//  PokemonDetailViewController.swift
//  iOS12-Pokedex
//
//  Created by Patrick Millet on 12/6/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var typesLabel: UILabel!
    
    //MARK: Properties
    
    var pokeController: PokemonController?
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        toggleSearchItems()
        updateViews()
    }
    
    
    // MARK: - Private
    
    private func updateViews() {
        togglePokemonItems()
        guard let pokemon = pokemon else { return }

        if let data = pokemon.image {
            let image = UIImage(data: data)
            imageView.image = image
        } else {
            pokeController?.fetchImage(for: pokemon, completion: { result in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                } else {
                    print(result)
                }
            })
        }

        nameLabel.text = capitalize(pokemon.name)
        idLabel.text = "ID: \(pokemon.id)"
        var types = pokemon.types.compactMap { $0.type.name }

        _ = types.compactMap {
        if let index = types.firstIndex(of: $0) {
            types[index] = capitalize($0) }
        }

        typesLabel.text = "Types: \(types.joined(separator: ", "))"


        var abilities = pokemon.abilities.compactMap { $0.ability.name }
        _ = abilities.compactMap {
            if let index = abilities.firstIndex(of: $0) {
                abilities[index] = capitalize($0) }
            }
        abilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", "))"
    }

    private func capitalize(_ word: String) -> String {
        var newWord = word
        let firstLetter = newWord.startIndex
        let capFirst = newWord[firstLetter].uppercased()
        newWord.remove(at: firstLetter)
        newWord.insert(Character(capFirst), at: firstLetter)
        return newWord
    }

    private func toggleSearchItems() {
        if pokemon != nil {
            navigationItem.title = capitalize(pokemon?.name ?? "")
            searchBar.isHidden = true
            saveButton.isHidden = true
        }
    }

    private func togglePokemonItems() {
        if pokemon != nil {
            imageView.isHidden = false
            nameLabel.isHidden = false
            idLabel.isHidden = false
            typesLabel.isHidden = false
            abilitiesLabel.isHidden = false
        } else {
            imageView.isHidden = true
            nameLabel.isHidden = true
            idLabel.isHidden = true
            typesLabel.isHidden = true
            abilitiesLabel.isHidden = true
        }
    }

    //MARK: Actions
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let pokemon = pokemon else {
                    navigationController?.popViewController(animated: true)
                    return }
            pokeController?.save(pokemon: pokemon)
            navigationController?.popViewController(animated: true)
        }
    }

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        pokeController?.fetchPokemon(named: searchTerm, completion: { result in
            let pokemon = try? result.get()
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        })
    }
}
