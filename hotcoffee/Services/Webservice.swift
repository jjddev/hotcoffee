//
//  Webservice.swift
//  hotcoffee
//
//  Created by juliano jose dziadzio on 02/10/19.
//  Copyright © 2019 juliano jose dziadzio. All rights reserved.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
}

enum NetWorkError: Error {
    case decodingError
    case domainError
    case urlError
}

class Webservice {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetWorkError>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let _result = result {
                DispatchQueue.main.async {
                    completion(.success(_result))
                }
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
