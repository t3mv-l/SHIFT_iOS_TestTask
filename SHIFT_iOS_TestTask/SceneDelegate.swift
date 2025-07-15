//
//  SceneDelegate.swift
//  SHIFT_iOS_TestTask
//
//  Created by Артём on 15.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = UINavigationController(rootViewController: RegistrationViewController())
        
        window?.makeKeyAndVisible()
    }
}

