//
//  LoginSceneViewControllerTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
@testable import CleanLogin

final class LoginSceneViewControllerTests: XCTestCase {
    private var sut: LoginSceneViewController!
    private var interactor: LoginSceneInteractorSpy!
    private var router: LoginSceneRoutingLogicSpy!
    
    override func setUp() {
        super.setUp()
        
        sut = LoginSceneViewController()
        interactor = LoginSceneInteractorSpy()
        sut.interactor = interactor
        router = LoginSceneRoutingLogicSpy()
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        
        super.tearDown()
    }
    
    func test_givenScene_whenLoginButtonTapped_thenInteractorCalled() {
        tapLoginButton()
        
        XCTAssertTrue(interactor.tryToLogInCalled)
    }
    
    func test_givenScene_whenPresenterCallsToShowLoginSuccess_thenRouterCalled() {
        sut.showLogingSuccess(fullUserName: "Andrzej Andrzej")
        
        XCTAssertTrue(router.showLoginSuccessCalled)
    }
    
    func test_givenScene_whenPresenterCallsToShowLoginFailure_thenRouterCalled() {
        sut.showLogingFailure(message: ":(")
        
        XCTAssertTrue(router.showLogingFailureCalled)
    }
}

private extension LoginSceneViewControllerTests {
    func tapLoginButton() {
        let mirror = Mirror.init(reflecting: sut.view as Any)
        for child in mirror.children {
            if let view = child.value as? UIView {
                for subview in view.subviews {
                    if let button = subview as? UIButton {
                        button.sendActions(for: .touchUpInside)
                    }
                }
            }
        }
    }
}

private final class LoginSceneInteractorSpy: LoginSceneInteractorInput {
    var tryToLogInCalled = false
    func tryToLogIn() {
        tryToLogInCalled = true
    }
}

private final class LoginSceneRoutingLogicSpy: LoginSceneRoutingLogic {
    var showLoginSuccessCalled = false
    func showLoginSuccess() {
        showLoginSuccessCalled = true
    }
    
    var showLogingFailureCalled = false
    func showLogingFailure(message: String) {
        showLogingFailureCalled = true
    }
}
