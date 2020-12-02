//
//  ViewControllerFactory.swift
//  CleanLogin
//
//  Created by Patryk Strzemiecki on 01/12/2020.
//

import Foundation

protocol SceneFactory {
    var configurator: LoginSceneConfigurator! { get set }
    func makeLoginScene() -> LoginSceneViewController
}

final class DefaultSceneFactory: SceneFactory {
    var configurator: LoginSceneConfigurator!
    
    func makeLoginScene() -> LoginSceneViewController {
        let vc = LoginSceneViewController()
        return configurator.configured(vc)
    }
}
