//
//  ___FILENAME___
//  ___PROJECTNAME___
//

import Foundation

protocol ___VARIABLE_sceneName___SceneConfigurator {
    func configured(
        _ viewController: ___VARIABLE_sceneName___SceneViewController
    ) -> ___VARIABLE_sceneName___SceneViewController
}

// swiftlint:disable colon
final class Default___VARIABLE_sceneName___SceneConfigurator:
    ___VARIABLE_sceneName___SceneConfigurator {
    func configured(
        _ viewController: ___VARIABLE_sceneName___SceneViewController
    ) -> ___VARIABLE_sceneName___SceneViewController {
        let interactor = ___VARIABLE_sceneName___SceneInteractor()
        let presenter = ___VARIABLE_sceneName___ScenePresenter()
        let router = ___VARIABLE_sceneName___SceneRouter()
        router.source = viewController
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
