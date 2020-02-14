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

    @IBOutlet weak var saveButton: UIButton!
     
    var pokemon: Pokemon?
    
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
        nameLabel.text = "\(apiController.pokemon.name.uppercased())"
        pokeIdLabel.text = "ID :\(apiController.pokemon.id)"
        guard  let urlImage = URL(string: (apiController.pokemon.image?.image ?? "")) else { return }
        pokemonImage.load(url:urlImage)
       
        
    }
   
    @IBAction func saveTapped(_ sender: UIButton) {
        delegate?.didReceivePokemon(with: Pokemon(id: apiController.pokemon.id, name: apiController.pokemon.name, abilities: apiController.pokemon.abilities, image: apiController.pokemon.image))
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK : - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let pokemon = pokemon {
            nameLabel.text = "\(pokemon.name.capitalizingFirstLetter())"
            pokeIdLabel.text = "ID :\(pokemon.id)"
            
        } else {
            title = "Pokemon Search"
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
    }

}

extension PokemonDetailVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
     
        apiController.performSearch(searchTerm: searchTerm) { (error) in
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
