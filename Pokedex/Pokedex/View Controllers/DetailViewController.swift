//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    
    var pokedex: Pokedex!
    var pokemon: Pokemon?

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearLabels()
        searchBar.delegate = self
        if pokemon != nil {
            deleteButton.isEnabled = true
            searchBar.isHidden = true
            saveButton.isHidden = true
            updateViews()
        }
    }
    
    func updateViews() {
            guard let pokemon = pokemon else { return }
            titleLabel.text = pokemon.name
            idLabel.text = "ID: " + String(pokemon.id)
            typesLabel.text = "Types: "
            for type in pokemon.types {
                typesLabel.text! += "\(type.type.name) "
            }
            abilitiesLabel.text = "Abilities: "
            for ability in pokemon.abilities {
                abilitiesLabel.text! += "\(ability.ability.name) "
        }
        pokedex.fetchImage(at: pokemon.sprites.frontDefault) { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    func clearLabels() {
        titleLabel.text = ""
        idLabel.text = ""
        abilitiesLabel.text = ""
        typesLabel.text = ""
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokedex.pokemon.append(pokemon)
        print("pokemon saved.")
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        if let deleteIndex = pokedex.pokemon.firstIndex(where: { $0 == pokemon }) {
            pokedex.pokemon.remove(at: deleteIndex)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension DetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("Search triggered")
        guard let search = searchBar.text?.lowercased(),
            !search.isEmpty else { return }
        
        print("Past the guard text: \(search)")
        pokedex.getPokemon(for: search) { result in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    print("Set pokemon")
                    self.updateViews()
                }
            }
        }
    }
}
