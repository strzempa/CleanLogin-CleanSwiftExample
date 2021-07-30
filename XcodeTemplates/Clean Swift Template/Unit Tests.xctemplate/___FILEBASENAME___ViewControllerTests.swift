//
//  ___FILENAME___
//  ___PROJECTNAME___
//

@testable import ___PROJECTNAMEASIDENTIFIER___
import XCTest

final class ___VARIABLE_sceneName___SceneViewControllerTests: XCTestCase {
    
    private var sut: ___VARIABLE_sceneName___SceneViewController!
    private var interactor: ___VARIABLE_sceneName___SceneInteractorMock!
    private var router: ___VARIABLE_sceneName___SceneRouterMock!
    private var contentView: ___VARIABLE_sceneName___SceneViewMock!
    
    override func setUp() {
        super.setUp()
        
        UIView.setAnimationsEnabled(false)
        
        interactor = ___VARIABLE_sceneName___SceneInteractorMock()
        router = ___VARIABLE_sceneName___SceneRouterMock()
        contentView = ___VARIABLE_sceneName___SceneViewMock()
        sut = ___VARIABLE_sceneName___SceneViewController(
            contentView: contentView
        )
        sut.interactor = interactor
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        contentView = nil
        
        super.tearDown()
    }
}

// swiftlint:disable colon
final class ___VARIABLE_sceneName___SceneInteractorMock:
    ___VARIABLE_sceneName___SceneInteractorInput {
    
}

// swiftlint:disable colon
final class ___VARIABLE_sceneName___SceneRouterMock:
    ___VARIABLE_sceneName___SceneRoutingLogic {
    
}

// swiftlint:disable colon
final class ___VARIABLE_sceneName___SceneViewMock:
    UIView, ___VARIABLE_sceneName___SceneView {
    weak var delegate: ___VARIABLE_sceneName___SceneViewDelegate?
}
