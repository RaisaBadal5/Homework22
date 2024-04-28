//
//  NameModel.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import Foundation

struct Name: Decodable {
    let common: String?
    let nativeName: NativeName?
    
    enum CodingKeys: String, CodingKey {
        case common
        case nativeName
    }
}
