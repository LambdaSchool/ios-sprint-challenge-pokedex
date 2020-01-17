//
//  DetailViewController.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 1/17/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    
    var apiController: ApiController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let unwrappedPokemon = pokemon else {return}
        apiController?.pokemonArray.append(unwrappedPokemon)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else {return}
        guard let pokemon = pokemon else {return}
        title = pokemon.name?.capitalized
        nameLabel.text = pokemon.name?.capitalized
        idLabel.text = "ID: \("\(pokemon.id!)")"
        typeLabel.text = "Types: \(pokemon.types[0].type.name)"
        abilitiesLabel.text = "Abilities: \(pokemon.abilities[0].ability.name)"
        guard let imageData = try? Data(contentsOf: pokemon.sprites.front_default) else {return}
        imageView.image = UIImage(data: imageData)
    }
}

extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // should lowercase the text
        print("entered search")
        guard let search = searchBar.text, !search.isEmpty else {return}
        
        let lowerSearch = search.lowercased()
        
        apiController?.fetchPokemon(name: lowerSearch) { (result) in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                    print("pokemon: \(pokemon)")
                }
            }
        }
    }
}
