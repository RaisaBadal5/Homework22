//
//  NativeNameModel.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import Foundation

struct NativeName: Decodable {
    let common: String?
    
    enum CodingKeys: String, CodingKey {
        case common
    }
}
