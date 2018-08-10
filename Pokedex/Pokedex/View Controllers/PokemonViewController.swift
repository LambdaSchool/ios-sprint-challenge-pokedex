//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Simon Elhoej Steinmejer on 10/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate
{
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    {
        didSet
        {
            guard let pokemon = pokemon else { return }
            updateViews(pokemon: pokemon, isSearchResult: false)
        }
    }
    var searchedPokemon: Pokemon?
    {
        didSet
        {
            guard let pokemon = searchedPokemon else { return }
            updateViews(pokemon: pokemon, isSearchResult: true)
        }
    }
    
    lazy var searchBar: UISearchBar =
    {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "Search by name or ID"
        
        return sb
    }()
    
    let nameLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    let pokemonImageView: UIImageView =
    {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 6
        
        return iv
    }()
    
    let idLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        
        return label
    }()
    
    let typesLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        
        return label
    }()
    
    let abilitiesLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        
        return label
    }()
    
    let saveButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Pokemon Search"
        
        setupUI()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        guard let searchTerm = searchBar.text else { return }
        
        searchBar.resignFirstResponder()
        
        pokemonController?.searchPokemon(with: searchTerm, completion: { (pokemon, error) in
            
            if let error = error
            {
                NSLog("There was an error \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ooops!", message: "An error occured while searching for the pokemon, please try again!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            
            DispatchQueue.main.async {
                self.searchedPokemon = pokemon
            }
        })
    }
    
    private func updateViews(pokemon: Pokemon, isSearchResult: Bool)
    {
        if !isSearchResult
        {
            title = pokemon.name
            searchBar.isHidden = true
            saveButton.isHidden = true
        }
        else
        {
            saveButton.isHidden = false
        }
        
        nameLabel.text = pokemon.name
        
        var abilityString = "Abilities: "
        for ability in pokemon.abilities!
        {
            let string = "\(ability.ability?.name ?? ""), "
            abilityString.append(string)
        }
        abilitiesLabel.text = abilityString
        
        var typeString = "Types: "
        for type in pokemon.types!
        {
            let string = "\(type.type?.name ?? ""), "
            typeString.append(string)
        }
        typesLabel.text = typeString
        
        if let idString = pokemon.id
        {
            idLabel.text = "ID: \(String(idString))"
        }
        
        if let urlString = pokemon.sprites?.front_default
        {
            pokemonImageView.loadImageUrlString(urlString)
        }
        
        view.layoutIfNeeded()
    }
    
    @objc private func handleSave()
    {
        guard let pokemon = searchedPokemon else { return }
        
        pokemonController?.savePokemon(with: pokemon)
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI()
    {
        let stackView = UIStackView(arrangedSubviews: [idLabel, abilitiesLabel, typesLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        view.addSubview(searchBar)
        view.addSubview(nameLabel)
        view.addSubview(pokemonImageView)
        view.addSubview(stackView)
        view.addSubview(saveButton)
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        
        nameLabel.anchor(top: searchBar.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        pokemonImageView.anchor(top: nameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.anchor(top: pokemonImageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 100)
        
        saveButton.anchor(top: stackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 40)
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}














