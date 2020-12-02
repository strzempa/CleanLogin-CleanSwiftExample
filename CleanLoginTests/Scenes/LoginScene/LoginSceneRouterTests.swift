//
//  LoginSceneRouterTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
@testable import CleanLogin

final class LoginSceneRouterTests: XCTestCase {
    private var sut: LoginSceneRouter!
    private var sceneFactory: SceneFactoryMock!
    private var source: SourceVCMock!
    private var navigationController: UINavigationControllerMock!
    
    override func setUp() {
        super.setUp()
        
        sceneFactory = SceneFactoryMock()
        source = SourceVCMock()
        navigationController = UINavigationControllerMock(rootViewController: source)
        sut = LoginSceneRouter(sceneFactory: sceneFactory)
        sut.source = source
    }
    
    override func tearDown() {
        sut = nil
        source = nil
        sceneFactory = nil
        navigationController = nil
        
        super.tearDown()
    }
    
    func test_givenRouter_whenShowLogingFailure_thenPresentCalledOnSource() {
        sut.showLogingFailure(message: ":(")
        
        XCTAssertTrue(source.presentCalled)
    }
    
    func test_givenRouter_whenShowLogingSuccess_thenPresentCalledOnSource() {
        sut.showLoginSuccess()

        XCTAssertTrue(navigationController.pushViewControllerCalled)
    }
}

private final class SceneFactoryMock: SceneFactory {
    var configurator: LoginSceneConfigurator!
    
    func makeLoginScene() -> UIViewController {
        UIViewController()
    }
}

private final class UINavigationControllerMock: UINavigationController {
    var pushViewControllerCalled = false
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }
}

private final class SourceVCMock: UINavigationController {
    var presentCalled = false
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
    }
}
