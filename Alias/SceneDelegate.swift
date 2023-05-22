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
        
        let serviceAssembly = ServiceAssembly()
                let loginPresenter = LoginPresenter(userService: serviceAssembly.makeUserService())
                let loginVC = LoginViewController(output: loginPresenter)
                loginPresenter.viewInput = loginVC
//        let presenter = JoinRoomPresenter(roomService: serviceAssembly.makeRoomService())
//        let vc = JoinRoomViewController(output: presenter)
//        presenter.viewInput = vc
        
        let navigationController = UINavigationController(rootViewController:loginVC)
        
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

