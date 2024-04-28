//
//  CountryModel.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import Foundation

struct CountryModel: Decodable {
    let name: Name?
    let flag: String?
    let flags: Flags?
    let capital: [String]?
    let region: String?
    let borders: [String]?
    let altSpellings: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case flag
        case flags
        case capital
        case region
        case borders
        case altSpellings
    }
}
