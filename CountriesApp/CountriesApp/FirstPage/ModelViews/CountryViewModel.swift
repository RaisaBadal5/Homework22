//
//  CountryViewModel.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import UIKit

class CountryViewModel {

    public var countries: [CountryModel] = []
    
    func fetchData(completion: @escaping () -> Void) {
            let url = URL(string: "https://restcountries.com/v3.1/all")!
            URLSession.shared.fetchData(at: url) { result in
                switch result {
                case .success(let country):
                    self.countries = country
                    completion()
                case .failure(let error):
                    print("Ohno, an error, let's handle it \(error)")
                }
            }
        }
    func getData() -> [CountryModel] {
        return countries
    }
}

extension URLSession {
  func fetchData(at url: URL, completion: @escaping (Result<[CountryModel], Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let toDos = try JSONDecoder().decode([CountryModel].self, from: data)
          completion(.success(toDos))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
