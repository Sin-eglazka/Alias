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
    
    static let baseUrl = "https://alias-swift-api.onrender.com/"
    
    
}

enum Endpoints{
    static let users = "users"
}
