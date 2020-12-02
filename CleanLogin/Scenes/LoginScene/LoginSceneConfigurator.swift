//
//  LoginSceneConfigurator.swift
//  CleanLogin
//
//  Created by Patryk Strzemiecki on 01/12/2020.
//

import Foundation

protocol LoginSceneConfigurator {
    func configured(_ vc: LoginSceneViewController) -> LoginSceneViewController
}

final class DefaultLoginSceneConfigurator: LoginSceneConfigurator {
    private var sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
    
    @discardableResult
    func configured(_ vc: LoginSceneViewController) -> LoginSceneViewController {
        sceneFactory.configurator = self
        let service = DefaultAuthService(
            networkManager: DefaultNetworkManager(session: MockNetworkSession())
        )
        let authWorker = LoginSceneAuthWorker(service: service)
        let interactor = LoginSceneInteractor()
        let presenter = LoginScenePresenter()
        let router = LoginSceneRouter(sceneFactory: sceneFactory)
        router.source = vc
        presenter.viewController = vc
        interactor.presenter = presenter
        interactor.authWorker = authWorker
        vc.interactor = interactor
        vc.router = router
        return vc
    }
}
