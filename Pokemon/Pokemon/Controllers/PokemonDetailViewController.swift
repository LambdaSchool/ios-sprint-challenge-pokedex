//
//  ViewController.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
  
  var apiController: NetworkingService?
  var pokemon: Pokemon?
  
  @IBOutlet weak var pokemonSearchBar: UISearchBar!
  @IBOutlet weak var saveButton: UIButton! {   didSet {  saveButton.isHidden = true } }
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var pokeAbiLabel: UILabel!
  @IBOutlet weak var pokemonImage: UIImageView!
  @IBOutlet weak var pokeTypeLabel: UILabel!
  @IBOutlet weak var pokeIdLabel: UILabel!
  
  private func updateViews(for pokemon: Pokemon) {
    
    saveButton.isHidden = false
    nameLabel.text = "\(pokemon.name.capitalizingFirstLetter())"
    pokeIdLabel.text = "ID :\(pokemon.id)"
    let urlImage = URL(string: (pokemon.image?.image ?? ""))
    pokemonImage.load(url:urlImage!)
    let type = pokemon.types.first!.type["name"]
    pokeTypeLabel.text = "Type: \(type!.capitalizingFirstLetter())"
    
    
    let abilities = pokemon.abilities.compactMap { $0.ability["name"] }
    
    pokeAbiLabel.text = abilities.joined(separator: ",").capitalizingFirstLetter()
    
  }
  
  @IBAction func saveTapped(_ sender: UIButton) {
    
    navigationController?.popViewController(animated: true)
  }
  
  //MARK : - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pokemonSearchBar.delegate = self
    pokemonSearchBar.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    
    self.navigationController?.setToolbarHidden(false, animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.setToolbarHidden(true, animated: true)
    
    if let pokemon = pokemon {
      saveButton.isHidden = true
      pokemonSearchBar.isHidden = true
      
      nameLabel.text = "\(pokemon.name.capitalizingFirstLetter())"
      pokeIdLabel.text = "ID :\(pokemon.id)"
      
      guard let urlString = pokemon.image?.image,
        let type = pokemon.types.first!.type["name"],
        let url = URL(string: urlString) else { return }
      
      pokemonImage.load(url: url )
      pokeTypeLabel.text = "Type: \(type.capitalizingFirstLetter())"
      
      pokeAbiLabel.text = "Abilities:\( pokemon.abilities.compactMap {$0.ability["name"] }.joined(separator: " ,").capitalizingFirstLetter())."
      
    } else {
      title = "Pokemon Search"
    }
  }
}

extension PokemonDetailViewController : UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text else { return }
    apiController?.performSearch(searchTerm: searchTerm, completion: { (result) in
      switch result {
        case .success(let pokemon):
          self.apiController?.createPokemon(with: pokemon)
          DispatchQueue.main.async {
            self.updateViews(for: pokemon)
        }
        case .failure(let error):
          print(error.localizedDescription)
      }
    })
  }
}

