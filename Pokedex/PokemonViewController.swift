//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Kenneth Jones on 5/17/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var spriteView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemonController: PokemonController!
    var pokemon: Pokemon?
    
    var buttonHidden = true
    var searchBarHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !searchBar.isHidden {
            searchBar.becomeFirstResponder()
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }
        pokemonController.pokemon.append(pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        if let pokemon = pokemon {
            title = pokemon.name.capitalizingFirstLetter()
            pokemonLabel.text = pokemon.name.capitalizingFirstLetter()
            idLabel.text = "ID: \(pokemon.id)"
            downloadImage(from: pokemon.sprite)
            displayArrayData(for: "types", in: typeLabel, from: pokemon.types)
            displayArrayData(for: "abilities", in: abilityLabel, from: pokemon.abilities)
        } else {
            title = "Pokemon Search"
        }
        
        searchBar.isHidden = searchBarHidden
        saveButton.isHidden = buttonHidden
    }
    
    private func displayArrayData(for type: String, in label: UILabel, from data: [String]) {
        var finalString = "\(type.capitalizingFirstLetter()): "
        itemLoop: for item in data {
            while item != data.last {
                finalString += "\(item.capitalizingFirstLetter()), "
                continue itemLoop
            }
            finalString += "\(item.capitalizingFirstLetter())"
        }
        label.text = finalString
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.spriteView.image = UIImage(data: data)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        self.pokemonController.fetchPokemon(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                do {
                    self.pokemon = try result.get()
                    self.buttonHidden = false
                    self.updateViews()
                } catch {
                    let alertController = UIAlertController(title: "No Data", message: "This Pokemon doesn't exist.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
            }
        }
    }

}
