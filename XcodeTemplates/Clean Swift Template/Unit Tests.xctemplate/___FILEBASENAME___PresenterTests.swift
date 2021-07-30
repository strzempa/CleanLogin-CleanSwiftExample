//
//  ___FILENAME___
//  ___PROJECTNAME___
//

@testable import ___PROJECTNAMEASIDENTIFIER___
import XCTest

final class ___VARIABLE_sceneName___ScenePresenterTests: XCTestCase {
    
    private var sut: ___VARIABLE_sceneName___ScenePresenter!
    private var viewController: ___VARIABLE_sceneName___SceneViewControllerMock!
    private var router: ___VARIABLE_sceneName___SceneRouterMock!
    
    override func setUp() {
        super.setUp()
        
        UIView.setAnimationsEnabled(false)
        
        viewController = ___VARIABLE_sceneName___SceneViewControllerMock()
        router = ___VARIABLE_sceneName___SceneRouterMock()
        viewController.router = router
        sut = ___VARIABLE_sceneName___ScenePresenter()
        sut.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        router = nil
        
        super.tearDown()
    }
}

// swiftlint:disable colon
final class ___VARIABLE_sceneName___SceneViewControllerMock:
    ___VARIABLE_sceneName___SceneViewControllerInput {
    var router: ___VARIABLE_sceneName___SceneRoutingLogic?
}
