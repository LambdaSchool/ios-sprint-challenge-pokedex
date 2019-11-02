//
//  ViewController.swift
//  Pokedex-SprintChallenge
//
//  Created by morse on 11/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokeController: PokeController?
    var pokemon: Pokemon? {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        toggleSearchItems()
        updateViews()
        saveImage()
    }
    
    func saveImage() {
        guard let pokemon = pokemon else { return }
        pokeController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { result in
            if let thisImage = try? result.get() {
                guard let index = self.pokeController?.pokemons.firstIndex(of: pokemon) else { return }
                
                self.pokeController?.pokemons[index].image = thisImage.pngData()
                
            }
        })
    }
    
    func updateViews() {
        togglePokemonItems()
        guard let pokemon = pokemon else { return }
        if let data = pokemon.image {
            let image = UIImage(data: data)
            imageView.image = image
        } else {
            pokeController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { result in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            })
        }
        nameLabel.text = pokeController?.capitalize(pokemon.name)
        idLabel.text = "ID: \(pokemon.id)"
        var types = pokemon.types.compactMap { $0.type.name }
        
        _ = types.compactMap {
        if let index = types.firstIndex(of: $0) {
            types[index] = self.pokeController?.capitalize($0) ?? $0 }
        }
        
        typesLabel.text = "Types: \(types.joined(separator: ", "))"
        
        
        var abilities = pokemon.abilities.compactMap { $0.ability.name }
        _ = abilities.compactMap {
            if let index = abilities.firstIndex(of: $0) {
                abilities[index] = self.pokeController?.capitalize($0) ?? $0 }
            }
        abilitiesLabel.text = "Abilities: \(abilities.joined(separator: ", "))"
    }
    
    func toggleSearchItems() {
        if pokemon != nil {
            navigationItem.title = pokeController?.capitalize(pokemon?.name ?? "")
            searchBar.isHidden = true
            saveButton.isHidden = true
        } //
    }
    
    func togglePokemonItems() {
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
