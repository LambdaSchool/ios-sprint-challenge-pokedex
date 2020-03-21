//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Elizabeth Thomas on 3/20/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIdNumber: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    // MARK: - Properites
    var pokemonController: PokemonController!
    private var pokemon: Pokemon?
    
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return}
        pokemonController.pokemonList.append(pokemon)
        
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }


}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
                
        pokemonController.fetchPokemon(name: searchTerm) { (result) in
            guard let pokemon = try? result.get() else { return }
            
            DispatchQueue.main.async {
                self.updateViews(with: pokemon)
            }
            
            self.pokemonController.fetchImage(at: pokemon.sprites.front_default) { (result) in
                guard let image = try? result.get() else { return }
                
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }
//        
//        DispatchQueue.main.async {
//            self.title = self.pokemon?.name.capitalized
//            self.pokemonNameLabel.text = self.pokemon?.name
//            self.pokemonIdNumber.text = "\(self.pokemon?.id)"
//            self.pokemonTypeLabel.text = "\(self.pokemon?.types)"
//            self.pokemonAbilitiesLabel.text = "\(self.pokemon?.abilities)"
//        }
    }
    
    private func updateViews(with pokemon: Pokemon) {
        title = pokemon.name
        pokemonNameLabel.text = pokemon.name
        pokemonIdNumber.text = String(pokemon.id)
        pokemonTypeLabel.text = "\(pokemon.types)"
        pokemonAbilitiesLabel.text = "\(pokemon.abilities)"
       
    }
}
