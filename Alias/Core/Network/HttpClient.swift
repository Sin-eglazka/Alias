//
//  HttpRequest.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation

class HttpClient{
    
    private init(){}
    
    static let shared = HttpClient()
    

    
    func fetch <T: Codable> (url: URL) async throws -> [T]{
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            throw HttpError.badResponse
        }
        
        guard let object = 	try? JSONDecoder().decode([T].self, from: data) else{
            throw HttpError.errorDecodingData
        }
        return object
    }
    
}

enum HttpError: Error{
    case badURL, badResponse, errorDecodingData, invalidURL
}


