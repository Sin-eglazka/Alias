//
//  ServiceAssembly.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation

final class ServiceAssembly {

    private lazy var networkService: NetworkServiceProtocol = {
        NetworkService()
    }()
    
    private lazy var requestFactory: URLRequestFactoryProtocol = {
        URLRequestFactory(host: Constants.baseUrl)
    }()

    func makeUserService() -> UserServiceProtocol {
        UserService(networkService: networkService, requestFactory: requestFactory)
    }
    
    func makeRoomService() -> RoomServiceProtocol {
        RoomService(networkService: networkService, requestFactory: requestFactory)
    }
    
    func makeGameService() -> GameServiceProtocol {
        GameService(networkService: networkService, requestFactory: requestFactory)
    }
    
    func makeTeamService() -> TeamServiceProtocol {
        TeamService(networkService: networkService, requestFactory: requestFactory)
    }
}
