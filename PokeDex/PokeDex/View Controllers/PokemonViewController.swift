//
//  PokemonViewController.swift
//  PokeDex
//
//  Created by William Chen on 9/6/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    let apiController = APIController()
    var userResults: UserResults?
    var user: User?
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        savePokemonButton.isHidden = true
        id.isHidden = true
        types.isHidden = true
        abilities.isHidden = true
        searchBar.delegate = self
        updateViews()
        
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        
        apiController.searchForPokemon(with: searchTerm) {_ in
            DispatchQueue.main.async {
                self.updateViews()
            }
            
        }
    }
    func updateViews(){
        guard let user = user else {return}
        nameLabel.text = user.name
        guard let imageData = try? Data(contentsOf: user.image) else { fatalError() }
        imageView.image = UIImage(data: imageData)
        
    }
    @IBAction func savePokemonClicked(_ sender: UIButton) {
        guard isViewLoaded,
            let user = user else {return}
        guard let pokemonName = searchBar.text else {return}
        guard let imageData = try? Data(contentsOf: user.image) else { fatalError() }
        imageView.image = UIImage(data: imageData)
        
        let newPokemon = User(name: pokemonName, image: user.image)
        userResults?.results.append(newPokemon)
        navigationController?.popViewController(animated: true)
        
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
