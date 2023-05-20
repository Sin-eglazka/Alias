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
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = LoginViewController()
//        self.window = window
//        
//
//        window.makeKeyAndVisible()
        
        guard let windowScene = (scene as? UIWindowScene)
        else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController =
        UINavigationController(rootViewController:
        LoginViewController())
         window.rootViewController = navigationController
         self.window = window
         window.makeKeyAndVisible()
    }
}

