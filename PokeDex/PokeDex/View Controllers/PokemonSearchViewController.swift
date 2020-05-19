//
//  PokemonSearchViewController.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    private var pokemonController = PokedexController()
    private var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchBar.delegate = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func updateViews() {
        guard let pokemon = pokemon else { return }
        pokemonNameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
     
        let url = URL(string: "\(pokemon.sprite)")!
        downloadImage(from: url)
        
//        typesLabel.text = pokemon.types
//        abilitiesLabel.text = pokemon.abilities

    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.pokemonImageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func savePokemonTapped(_ sender: Any) {
    
     //   pokedexController.savePokemon(with: <#T##Pokemon#>)
    }
}

extension PokemonSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        pokemonController.searchForPokemonWith(searchTerm: searchTerm) { (newPokemon) in
            DispatchQueue.main.async {
                self.pokemon = self.pokemon
            }
        }
    }
}
