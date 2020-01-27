//
//  fetchPokemonInformation.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

class APIController{
    func fetchPokemonInformation(_ url: URL!, completion: @escaping (Result<PokemonInformation, NetworkError>) -> Void){
        
        //MARK: - Get URL Request Ready

        var request = URLRequest(url: url)

        request.httpMethod = HTTPMethod.get.rawValue

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                print("401")
                completion(.failure(.badAuth))
                return
            }

            guard error == nil else {
                print("other error")
                completion(.failure(.otherError))
                return
            }

            guard let data = data else {
                print("no data")
                completion(.failure(.badData))
                return
            }
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(PokemonInformation.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
