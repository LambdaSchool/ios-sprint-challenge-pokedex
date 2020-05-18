//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Kenneth Jones on 5/17/20.
//  Copyright © 2020 Kenneth Jones. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var spriteView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var pokemonController: PokemonController!
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
    }
    
    private func updateViews() {
        if let pokemon = pokemon {
            title = pokemon.name
            searchBar.isHidden = true
            saveButton.isHidden = true
            pokemonLabel.text = pokemon.name
            idLabel.text = String(pokemon.id)
            downloadImage(from: pokemon.sprite)
        } else {
            title = "Pokemon Search"
            searchBar.isHidden = false
            saveButton.isHidden = false
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.spriteView.image = UIImage(data: data)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
