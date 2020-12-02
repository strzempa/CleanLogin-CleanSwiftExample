//
//  LoginSceneInteractorTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
@testable import CleanLogin

final class LoginSceneInteractorTests: XCTestCase {
    private var sut: LoginSceneInteractor!
    private var worker: LoginSceneAuthWorkerMock!
    private var presenter: LoginScenePresenterInputMock!
    
    override func setUp() {
        super.setUp()
        
        sut = LoginSceneInteractor()
        worker = LoginSceneAuthWorkerMock()
        presenter = LoginScenePresenterInputMock()
        sut.presenter = presenter
        sut.authWorker = worker
    }
    
    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        
        super.tearDown()
    }
    
    func test_givenInteractor_whenTryToLogInCalled_thenWorkerCalled() {
        sut.tryToLogIn()
        
        XCTAssertTrue(worker.makeAuthCalled)
    }
    
    func test_givenInteractor_whenTryToLogInCalled_andWorkerReturnsResultSuccess_thenPresenterCalled() {
        let expectation1 = expectation(description: "Wait for makeAuth() to return")
        worker.makeAuthStub = .success(CleanLoginUser(firstName: "Apple", lastName: "Watch"))
        sut.tryToLogIn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showLogingSuccessCalled)
    }
    
    func test_givenInteractor_whenTryToLogInCalled_andWorkerReturnsResultFailure_thenPresenterCalled() {
        let expectation1 = expectation(description: "Wait for makeAuth() to return")
        worker.makeAuthStub = .failure(.unauthorized)
        sut.tryToLogIn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertTrue(presenter.showLogingFailureCalled)
    }
    
    func test_givenInteractor_whenTryToLogInCalled_andWorkerReturnsResultSuccess_thenProperDataPassedToPresenter() {
        let expectation1 = expectation(description: "Wait for makeAuth() to return")
        worker.makeAuthStub = .success(CleanLoginUser(firstName: "Apple", lastName: "Watch"))
        sut.tryToLogIn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(presenter.showLogingSuccessData.firstName, "Apple")
        XCTAssertEqual(presenter.showLogingSuccessData.lastName, "Watch")
    }
    
    func test_givenInteractor_whenTryToLogInCalled_andWorkerReturnsResultFailure_thenProperDataPassedToPresenter() {
        let expectation1 = expectation(description: "Wait for makeAuth() to return")
        worker.makeAuthStub = .failure(.unauthorized)
        sut.tryToLogIn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(presenter.showLogingFailureMessage,
                       "%22The%20operation%20couldn%E2%80%99t%20be%20completed.%20(CleanLogin.LoginSceneAuthWorker.LoginSceneAuthWorkerError%20error%201.)%22")
    }
}

private final class LoginSceneAuthWorkerMock: LoginSceneAuthLogic {
    var makeAuthStub: Result<CleanLoginUser, LoginSceneAuthWorker.LoginSceneAuthWorkerError>?
    var makeAuthCalled = false
    
    func makeAuth(completion: @escaping (Result<CleanLoginUser, LoginSceneAuthWorker.LoginSceneAuthWorkerError>) -> Void) {
        makeAuthCalled = true
        if let stub = makeAuthStub {
            completion(stub)
        }
    }
}

private final class LoginScenePresenterInputMock: LoginScenePresenterInput {
    var showLogingSuccessCalled = false
    var showLogingSuccessData: CleanLoginUser!
    func showLogingSuccess(user: CleanLoginUser) {
        showLogingSuccessCalled = true
        showLogingSuccessData = user
    }
    
    var showLogingFailureCalled = false
    var showLogingFailureMessage: String!
    func showLogingFailure(message: String) {
        showLogingFailureCalled = true
        showLogingFailureMessage = message.debugDescription.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
