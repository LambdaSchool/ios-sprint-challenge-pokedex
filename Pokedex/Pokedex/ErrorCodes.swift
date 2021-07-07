//
//  ErrorCodes.swift
//  Pokedex
//
//  Created by Craig Swanson on 11/10/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import Foundation

enum ErrorCodes: Error {

        case noAuthorization
        case incorrectAuthorization
        case badData
        case notDecodedProperly
        case otherError
        case notEncodedProperly

}
