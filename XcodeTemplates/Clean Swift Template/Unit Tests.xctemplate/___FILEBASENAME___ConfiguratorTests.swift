//
//  ___FILENAME___
//  ___PROJECTNAME___
//

@testable import ___PROJECTNAMEASIDENTIFIER___
import XCTest

// swiftlint:disable force_cast
final class ___VARIABLE_sceneName___SceneConfiguratorTests: XCTestCase {
    
    private var sut: ___VARIABLE_sceneName___SceneConfigurator!
    private var viewController: ___VARIABLE_sceneName___SceneViewController!
    
    override func setUp() {
        super.setUp()
        
        UIView.setAnimationsEnabled(false)
        
        viewController
            = ___VARIABLE_sceneName___SceneViewController(
                contentView: Default___VARIABLE_sceneName___SceneView()
            )
        sut = Default___VARIABLE_sceneName___SceneConfigurator()
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_configurator_configure_allDependenciesProperlyConfigured() {
        let configured = sut.configured(viewController)
        
        XCTAssertTrue(configured.router is ___VARIABLE_sceneName___SceneRouter)
        XCTAssertTrue(
            (configured.router as! ___VARIABLE_sceneName___SceneRouter)
                .source is ___VARIABLE_sceneName___SceneViewController
        )
        XCTAssertTrue(
            configured.interactor is ___VARIABLE_sceneName___SceneInteractor
        )
        XCTAssertTrue(
            (configured.interactor as! ___VARIABLE_sceneName___SceneInteractor)
                .presenter is ___VARIABLE_sceneName___ScenePresenter
        )
    }
}
