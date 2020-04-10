//
//  SearchDetailViewController.swift
//  Pokedex
//
//  Created by Chris Dobek on 4/10/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var apiController: APIController? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        searchBar.delegate = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        apiController?.addPokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let pokemon = pokemon, isViewLoaded {
            title = pokemon.name.capitalized
            pokemonNameLabel.text = pokemon.name.capitalized
            idLabel.text = "ID: \(pokemon.id)"
            
            var typesText: String = "\(pokemon.types[0].type.name.capitalized)"
            if pokemon.types.count > 1 {
                for i in 1..<pokemon.types.count {
                    typesText.append(", \(pokemon.types[i].type.name.capitalized)")
                }
            }
            
            typeLabel.text = "Types: \(typesText)"
            
            var abilitiesText: String = "\(pokemon.abilities[0].ability.name.capitalized)"
            if pokemon.abilities.count > 1 {
                for i in 1..<pokemon.abilities.count {
                    abilitiesText.append(", \(pokemon.abilities[i].ability.name.capitalized)")
                }
            }
            abilityLabel.text = "Abilities: \(abilitiesText)"
            
            guard let imageURL = URL(string: pokemon.sprites.imageUrl) else { return }
            imageView.load(url: imageURL)
            unhideLabel()
        } else {
            title = "Search Pokemon"
        }
    }
    
    func unhideLabel(){
        if pokemon != nil, isViewLoaded {
            pokemonNameLabel.isHidden = false
            idLabel.isHidden = false
            typeLabel.isHidden = false
            abilityLabel.isHidden = false
            saveButton.isHidden = false
        } else {
            pokemonNameLabel.isHidden = true
            idLabel.isHidden = true
            typeLabel.isHidden = true
            abilityLabel.isHidden = true
            saveButton.isHidden = true
        }
    }
}

extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let pokemon = searchBar.text,
        !pokemon.isEmpty {
            apiController?.fetchPokemon(pokemonName: pokemon) { result in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                        self.updateViews()
                    }
                }
            }
        }
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
