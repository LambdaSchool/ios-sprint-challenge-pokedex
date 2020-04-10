//
//  SearchViewController.swift
//  Pokedex Sprint Challenge
//
//  Created by Mark Poggi on 4/10/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var searchPokemonController = SearchPokemonController()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
            searchTerm != "" else { return }
        
        //        searchPokemonController.performSearch(for: searchTerm, completion: ){
        //            DispatchQueue.main.async {
        ////                self.tableView.reloadData()
        //            }
        //        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
    }
}
