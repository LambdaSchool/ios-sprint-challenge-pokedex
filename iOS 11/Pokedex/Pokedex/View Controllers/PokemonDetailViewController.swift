//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by brian vilchez on 11/1/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var PokemonID: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var savePokemon: UIButton!
    var pokemonAPI: PokemonAPIController?
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return configureviews() }
        guard let pokemonImageData = try? Data(contentsOf:pokemon.sprites.frontDefault) else {return}
        pokemonSearchBar.isHidden = true 
        pokemonImage.image = UIImage(data: pokemonImageData)
        pokemonNameLabel.text = pokemon.name
        PokemonID.text = "\(Int(pokemon.id))"
        for abilities in pokemon.abilities {
            pokemonAbilitiesLabel.text = abilities.ability.name
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let pokemon = pokemon else {return}
        pokemonAPI?.savePokemon(with: pokemon)
        navigationController?.popViewController(animated: true)
    }

    func configureviews() {
        pokemonSearchBar.delegate = self
        pokemonNameLabel.text = " "
        pokemonType.text = " "
        PokemonID.text = ""
        pokemonAbilitiesLabel.text = ""
        savePokemon.isHidden = true
        
    }
}

extension PokemonDetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonName = searchBar.text, !pokemonName.isEmpty else { return }
        pokemonAPI?.searchForPokemon(with: pokemonName.lowercased()) { (pokemon) in
            guard let seearchedPokemon = try? pokemon.get() else {return}
            DispatchQueue.main.async {
                self.pokemon = seearchedPokemon
                self.savePokemon.isHidden = false
            }
        }
    }
}
