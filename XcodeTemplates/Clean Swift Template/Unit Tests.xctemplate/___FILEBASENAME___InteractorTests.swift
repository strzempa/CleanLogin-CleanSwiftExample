//
//  ___FILENAME___
//  ___PROJECTNAME___
//

@testable import ___PROJECTNAMEASIDENTIFIER___
import XCTest

final class ___VARIABLE_sceneName___SceneInteractorTests: XCTestCase {
    
    private var sut: ___VARIABLE_sceneName___SceneInteractor!
    private var presenter: ___VARIABLE_sceneName___ScenePresenterMock!
    
    override func setUp() {
        super.setUp()
        
        UIView.setAnimationsEnabled(false)
        
        presenter = ___VARIABLE_sceneName___ScenePresenterMock()
        sut = ___VARIABLE_sceneName___SceneInteractor()
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        
        super.tearDown()
    }
}

// swiftlint:disable colon
final class ___VARIABLE_sceneName___ScenePresenterMock:
    ___VARIABLE_sceneName___ScenePresenterInput {}
