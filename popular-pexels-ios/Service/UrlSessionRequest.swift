//
//  UrlSessionRequest.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import Foundation

class UrlSessionRequest: HttpRequest {
    
    static func get<T: Codable>(_ params: HttpParams, completion: @escaping (Result<T, HttpError>) -> Void) {
        guard let url = params.createUrl() else {
            completion(.failure(.invalidPath))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("WthmszM6GSm261FKVwwcJ7954BURHAgLhJpR3EAiT6IcZfe7loVHB34v", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unexpected))
                return
            }

            guard (200..<300) ~= response.statusCode else {
                completion(.failure(.serverSideError(response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.serialization))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.serialization))
                return
            }
        }
        task.resume()
    }
}
