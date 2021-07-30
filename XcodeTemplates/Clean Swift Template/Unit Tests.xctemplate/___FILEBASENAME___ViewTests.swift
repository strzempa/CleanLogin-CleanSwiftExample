//
//  ___FILENAME___
//  ___PROJECTNAME___
//

@testable import ___PROJECTNAMEASIDENTIFIER___
import XCTest

// swiftlint:disable force_cast
final class ___VARIABLE_sceneName___SceneViewTests: XCTestCase {
    
    private var sut: ___VARIABLE_sceneName___SceneView!
    private var viewController: UIViewControllerMock!
    
    override func setUp() {
        super.setUp()
        
        UIView.setAnimationsEnabled(false)
        
        viewController = UIViewControllerMock()
        sut = Default___VARIABLE_sceneName___SceneView()
        sut.delegate = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
}

// swiftlint:disable colon
private final class UIViewControllerMock:
    UIViewController, ___VARIABLE_sceneName___SceneViewDelegate {}
