//
//  ViewController.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

protocol PokemonDetailVCDelegate : AnyObject {
    func didReceivePokemon(with pokemon: Pokemon)
}

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.cornerRadius = 20
        }
    }
     
    var pokemon: Pokemon?
   private var abilities = [String]()
    var apiController = APIController()
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar! {
        didSet {
            pokemonSearchBar.delegate = self
            pokemonSearchBar.becomeFirstResponder()
        }
    }
    weak var delegate: PokemonDetailVCDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeAbiLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokeTypeLabel: UILabel!
    @IBOutlet weak var pokeIdLabel: UILabel!
    
    private func updateViews() {
        nameLabel.text = "\(apiController.pokemon.name.capitalizingFirstLetter())"
        pokeIdLabel.text = "ID :\(apiController.pokemon.id)"
        guard  let urlImage = URL(string: (apiController.pokemon.image?.image ?? "")) else { return }
        pokemonImage.load(url:urlImage)
        guard let type = apiController.pokemon.types[0].type["name"] else { return }
        pokeTypeLabel.text = "Type: \(type.capitalizingFirstLetter())"
        
        
        apiController.pokemon.abilities.forEach { (ability) in
            abilities.append(ability.ability["name"]!)
            
        }
        pokeAbiLabel.text = "Abilities:\( Set(abilities).joined(separator: ",").capitalizingFirstLetter())."
        
    }
   
    @IBAction func saveTapped(_ sender: UIButton) {
        delegate?.didReceivePokemon(with: Pokemon(id: apiController.pokemon.id, name: apiController.pokemon.name, image: apiController.pokemon.image,types: apiController.pokemon.types,abilities: apiController.pokemon.abilities))
        apiController.createPokemon(with: Pokemon(id: apiController.pokemon.id, name: apiController.pokemon.name, image: apiController.pokemon.image,types: apiController.pokemon.types,abilities: apiController.pokemon.abilities))
        navigationController?.popViewController(animated: true)
    }
    
    //MARK : - View Life Cycle
    
   override func viewDidLoad() {
         super.viewDidLoad()
    
         
     }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    
            self.navigationController?.setToolbarHidden(false, animated: true)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        if let pokemon = pokemon {
            
            nameLabel.text = "\(pokemon.name.capitalizingFirstLetter())"
            pokeIdLabel.text = "ID :\(pokemon.id)"
          
            guard let urlString = pokemon.image?.image else { return }
            guard let type = pokemon.types[0].type["name"] else { return }
            guard let url = URL(string: urlString) else { return }
            pokemonImage.load(url: url )
            pokeTypeLabel.text = "Type: \(type.capitalizingFirstLetter())"
            var abis = [String]()
            pokemon.abilities.forEach {
                (ability) in
                abis.append(ability.ability["name"]!)
            }
            pokeAbiLabel.text = "Abilities:\( abis.joined(separator: ",").capitalizingFirstLetter())."
            
        } else {
            title = "Pokemon Search"
        }

    }
 
}

extension PokemonDetailVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
     
        apiController.performSearch(searchTerm: searchTerm) { (action) in
            DispatchQueue.main.async {
              
                self.updateViews()
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
