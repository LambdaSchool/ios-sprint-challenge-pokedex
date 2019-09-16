//
//  NetworkError.swift
//  Pokedex
//
//  Created by Casualty on 9/15/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError
    case noData
    case noDecode
}
