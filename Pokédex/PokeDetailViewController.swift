//
//  PokeDetailViewController.swift
//  Pokédex
//
//  Created by Thomas Sabino-Benowitz on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController {

   
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var pokeImageView: UIImageView!
    
    var pokemonAPI: PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
        
        nameLabel.text = pokemonAPI?.pokemon?.name.capitalized
        idLabel.text = "\(pokemonAPI?.pokemon?.id ?? 0)"
        
        if pokemonAPI?.pokemon?.sprites.front_default != nil {
        var pokeimageData = NSData(contentsOf: (pokemonAPI?.pokemon?.sprites.front_default)!)
            pokeImageView.image = UIImage(data: pokeimageData as! Data)
        }
        
        if pokemonAPI?.pokemon?.abilities.count == 3 {
                   abilitiesLabel.text = "\(pokemonAPI?.pokemon?.abilities[0].ability.name.capitalized ?? ""),  \(pokemonAPI?.pokemon?.abilities[1].ability.name.capitalized ?? ""), \n \(pokemonAPI?.pokemon?.abilities[2].ability.name.capitalized ?? "")"
               } else if pokemonAPI?.pokemon?.abilities.count == 2 {
                abilitiesLabel.text = "\(pokemonAPI?.pokemon?.abilities[0].ability.name.capitalized ?? ""),  \(pokemonAPI?.pokemon?.abilities[1].ability.name.capitalized ?? "")"
                } else if pokemonAPI?.pokemon?.abilities.count == 1 {
                   abilitiesLabel.text = "\(pokemonAPI?.pokemon?.abilities[0].ability.name.capitalized ?? "")"
               }
        
        if pokemonAPI?.pokemon?.types.count == 2 {
                  typesLabel.text = "\(pokemonAPI?.pokemon?.types[0].type.name.capitalized ?? ""), \(pokemonAPI?.pokemon?.types[1].type.name.capitalized ?? "")"
              } else if pokemonAPI?.pokemon?.types.count == 1 {
                  typesLabel.text = "\(pokemonAPI?.pokemon?.types[0].type.name.capitalized ?? "")"
              }
        // Do any additional setup after loading the view.
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
        nameLabel.text = pokemonAPI?.pokemon?.name.capitalized
        idLabel.text = "\(pokemonAPI?.pokemon?.id ?? 0)"
        
        let pokeimageData = NSData(contentsOf: (pokemonAPI?.pokemon?.sprites.front_default)!)
        pokeImageView.image = UIImage(data: pokeimageData! as Data)
        
        if pokemonAPI?.pokemon?.abilities.count == 3 {
            abilitiesLabel.text = "\(pokemonAPI?.pokemon?.abilities[0].ability.name.capitalized ?? ""),  \(pokemonAPI?.pokemon?.abilities[1].ability.name.capitalized ?? ""), \n \(pokemonAPI?.pokemon?.abilities[2].ability.name.capitalized ?? "")"
        } else if pokemonAPI?.pokemon?.abilities.count == 2 {
         abilitiesLabel.text = "\(pokemonAPI?.pokemon?.abilities[0].ability.name.capitalized ?? ""),  \(pokemonAPI?.pokemon?.abilities[1].ability.name.capitalized ?? "")"
         } else if pokemonAPI?.pokemon?.abilities.count == 1 {
            abilitiesLabel.text = "\(pokemonAPI?.pokemon?.abilities[0].ability.name.capitalized ?? "")"
        }
        
        if pokemonAPI?.pokemon?.types.count == 2 {
            typesLabel.text = "\(pokemonAPI?.pokemon?.types[0].type.name.capitalized ?? ""), \(pokemonAPI?.pokemon?.types[1].type.name.capitalized ?? "")"
        } else if pokemonAPI?.pokemon?.types.count == 1 {
            typesLabel.text = "\(pokemonAPI?.pokemon?.types[0].type.name.capitalized ?? "")"
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard pokemonAPI?.pokemon != nil else {return}
        pokemonAPI!.pokemonList.append(pokemonAPI!.pokemon!)
        
        navigationController?.popViewController(animated: true)
        
    }
}
extension PokeDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        print("\(searchTerm)")
        pokemonAPI?.SearchPokemon(searchTerm: searchTerm) {
            
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

}

