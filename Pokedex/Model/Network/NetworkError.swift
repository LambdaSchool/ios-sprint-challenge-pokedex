//
//  NetworkError.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case decodingError
}
