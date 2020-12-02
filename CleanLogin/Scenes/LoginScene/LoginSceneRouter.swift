//
//  LoginSceneRouter.swift
//  CleanLogin
//
//  Created by Patryk Strzemiecki on 01/12/2020.
//

import UIKit

protocol LoginSceneRoutingLogic {
    func showLoginSuccess()
    func showLogingFailure(message: String)
}

final class LoginSceneRouter {
    weak var source: UIViewController?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension LoginSceneRouter: LoginSceneRoutingLogic {
    func showLogingFailure(message: String) {
        let action = UIAlertAction(title: "OK", style: .destructive)
        let alertController
            = UIAlertController(title: "Login Failure",
                                message: message,
                                preferredStyle: .alert)
        alertController.addAction(action)
        source?.present(alertController, animated: true)
    }
    
    func showLoginSuccess() {
        let scene = sceneFactory.makeLoginScene()
        source?.navigationController?.pushViewController(scene, animated: true)
    }
}
