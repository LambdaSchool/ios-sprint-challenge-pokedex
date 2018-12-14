//
//  PokemSearchViewController.swift
//  ios-sprint3-challenge
//
//  Created by Austin Cole on 12/14/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    //MARK: declared outlet variables
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!

    //MARK: other declared variables

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = Model.shared.pokemon?.name
            self.pokemonIDLabel.text = "\(String(describing: Model.shared.pokemon?.id))"
            self.pokemonTypesLabel.text = Model.shared.pokemon?.types.description
            self.pokemonAbilitiesLabel.text = Model.shared.pokemon?.abilities.description
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let pokemonText = searchBar.text, !pokemonText.isEmpty else {return}
        PokemonModelController().fetchPokemon(for: pokemonText) { error in
            if error == nil {
               self.updateViews()
            }
        }
    }
//    private func updateViews() {
//        guard let pokemonSpriteImage = pokemonSpriteImageView else {return}
//        guard let url = URL(string: pokemonSpriteImage.frontDefault), let imageData = try? Data(contentsOf: url) else {return}
//        pokemonSpriteImageView.image = UIImage(data: imageData)
//    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
