//
//  FlagsModel.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import Foundation

struct Flags: Decodable {
    let alt: String?
    let png: URL?
    enum CodingKeys: String, CodingKey {
        case alt
        case png
    }
}
