//
//  SearchPokemonViewController.swift
//  Pokedex
//
//  Created by Hunter Oppel on 4/10/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    private lazy var viewModel = PokemonDetailViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.delegate = self
        
        nameLabel.isHidden = true
        spriteImage.isHidden = true
        idLabel.isHidden = true
        abilitiesLabel.isHidden = true
        typesLabel.isHidden = true
        saveButton.isHidden = true
    }
    
    private func updateViews(with pokemon: Pokemon) {
        nameLabel.isHidden = false
        spriteImage.isHidden = false
        idLabel.isHidden = false
        abilitiesLabel.isHidden = false
        typesLabel.isHidden = false
        saveButton.isHidden = false
        
        self.title = pokemon.name.uppercased()
        nameLabel.text = pokemon.name.uppercased()
        idLabel.text = String("ID: \(pokemon.id)")
        
        var abilitesStringArray = [String]()
        for ability in pokemon.abilities {
            abilitesStringArray.append(ability.ability.name)
        }
        abilitiesLabel.text =  "Abilites: \(abilitesStringArray.joined(separator: ","))"
        
        var typesStringArray = [String]()
        for type in pokemon.types {
            typesStringArray.append(type.type.name)
        }
        typesLabel.text = "Types: \(typesStringArray.joined(separator: ","))"
        
        
    }
    
    // MARK: - Actions
    
    @IBAction func save(_ sender: Any) {
    }
}

extension SearchPokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        viewModel.getPokemon(with: searchTerm) { result in
            switch result {
            case .successfulWithPokemon(let pokemon):
                self.updateViews(with: pokemon)
            case .successfulWithSprite(let sprite):
                self.spriteImage.image = sprite
            case .failure(let message):
                print(message)
            }
        }
    }
}
