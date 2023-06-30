//
//  HttpRequest.swift
//  popular-pexels-ios
//
//  Created by Bruno Duarte on 30/06/23.
//

import Foundation

struct HttpParams {
    let path: String
    let queryParams: [String: String]?
    
    func createUrl() -> URL? {
        var urlQueryParams = [URLQueryItem]()
        
        for queryParam in queryParams ?? [:] {
            urlQueryParams.append(URLQueryItem(name: queryParam.key, value: queryParam.value))
        }

        var urlComponents = URLComponents(string: "https://api.pexels.com/" + path)
        urlComponents?.queryItems = urlQueryParams
        return urlComponents?.url
    }
}

protocol HttpRequest {
    static func get<T: Codable>(_ params: HttpParams, completion: @escaping (Result<T, HttpError>) -> Void)
}

enum HttpError: Error, CustomStringConvertible {
    case invalidPath
    case transportError(Error?)
    case serverSideError(Int)
    case unexpected
    case serialization
    
    public var description: String {
        switch self {
        case .invalidPath:
            return "The requested path is not valid."
        case .transportError(let error):
            return "Some errors occurred while trying to request the server. Description: (\(error?.localizedDescription ?? ""))."
        case .serverSideError(let code):
            return "The request failed with the status code \(code)."
        case .unexpected:
            return "Some unexpected error ocurred."
        case .serialization:
            return "Cannot serialize response into requested object."
        }
    }
}
