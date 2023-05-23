//
//  SceneDelegate.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene)
        else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let serviceAssembly = ServiceAssembly()
        let userService = serviceAssembly.makeUserService()
        let roomService = serviceAssembly.makeRoomService()
        
        let loginPresenter = LoginPresenter(userService: userService, roomService: roomService)
        let loginVC = LoginViewController(output: loginPresenter)
        loginPresenter.viewInput = loginVC
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        if (UserDefaults.standard.object(forKey: "bearer token") is String) {
            let presenter = JoinRoomPresenter(roomService: roomService, userService: userService)
            let vc = JoinRoomViewController(output: presenter)
            presenter.viewInput = vc
            navigationController.pushViewController(vc, animated: true)
        }
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = vc
    }
}

