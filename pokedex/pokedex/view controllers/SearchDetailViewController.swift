//
//  SearchDetailViewController.swift
//  pokedex
//
//  Created by ronald huston jr on 5/8/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonLabel: UILabel!
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
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController?.savePokemon(pokemon: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        
        if let pokemon = pokemon, isViewLoaded {
            title = pokemon.name
            pokemonLabel.text = pokemon.name
            idLabel.text = "ID: \(pokemon.id)"
            
            var types: String = "\(pokemon.types[0].type.name)"
            if pokemon.types.count > 1 {
                for i in 1..<pokemon.types.count {
                    types.append(", \(pokemon.types[i].type.name)")
                }
            }
            
            typeLabel.text = "Types: \(types)"
            
            var ableText: String = "\(pokemon.abilities[0].ability.name)"
            
            if pokemon.abilities.count > 1 {
                for i in 1..<pokemon.abilities.count {
                    ableText.append(", \(pokemon.abilities[i].ability.name)")
                }
            }
            
            abilityLabel.text = "Abilities: \(ableText)"
            
            guard let imageURL = URL(string: pokemon.picture.url) else { return }
            imageView.load(url: imageURL)
            unhideLabel()
        } else {
            title = "search pokemon"
        }
    }
    
    func unhideLabel() {
        if pokemon != nil, isViewLoaded {
            pokemonLabel.isHidden = false
            idLabel.isHidden = false
            typeLabel.isHidden = false
            abilityLabel.isHidden = false
            saveButton.isHidden = false
        } else {
            pokemonLabel.isHidden = true
            idLabel.isHidden = true
            typeLabel.isHidden = true
            abilityLabel.isHidden = true
            saveButton.isHidden = true
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

//  search bar delegate
extension SearchDetailViewController: UISearchBarDelegate {
    func searchBarButtonTapped(searchBar: UISearchBar) {
        if let pokeName = searchBar.text,
            !pokeName.isEmpty {
            pokemonController?.fetchPokemon(pokemon: pokeName) { result in
                if let pokeName = try? result.get() {
                    DispatchQueue.main.async {
                        self.pokemon = pokeName
                        self.updateViews()
                    }
                }
            }
        }
    }
}
