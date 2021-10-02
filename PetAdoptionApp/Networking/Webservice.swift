//
//  Webservice.swift
//  PetAdoptionApp
//
//  Created by Tiago Miguel de Jesus Romao on 02/10/2021.
//

import Foundation

enum NetworkError:Error {
    case badRequest
    case DecodingError
}

class Webservice{
    
    func fetch<T: Codable>(url: URL, parse: @escaping (Data) -> T?, completion: @escaping (Result<T?, NetworkError>) -> Void ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(.failure(.DecodingError))
                return
            }
            let result = parse(data)
            completion(.success(result))
            
            
        }.resume()
        
        
    }
    
}
