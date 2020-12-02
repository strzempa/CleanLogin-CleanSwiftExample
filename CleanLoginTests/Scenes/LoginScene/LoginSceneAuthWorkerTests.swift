//
//  LoginSceneAuthWorkerTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
import Combine
@testable import CleanLogin

final class LoginSceneAuthWorkerTests: XCTestCase {
    private var sut: LoginSceneAuthWorker!
    private var service: AuthServiceMock!
    
    override func setUp() {
        super.setUp()
        
        service = AuthServiceMock()
        sut = LoginSceneAuthWorker(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        
        super.tearDown()
    }
    
    func test_givenWorker_whenServiceMakeAuthCalled_andReturnsSuccess_thenProperModelReturned() {
        let expectation1 = expectation(description: "Wait for makeAuth() to return")
        service.authStatusCodeStub = 200
        service.authRespondeDataStub = DefaultAuthService.Response(authorized: true, user: DefaultAuthService.Response.User(firstName: "First", lastName: "Last"))
        var authResult: CleanLoginUser!
        
        sut.makeAuth { result in
            authResult = try! result.get()
            expectation1.fulfill()
            
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(authResult.firstName, "First")
        XCTAssertEqual(authResult.lastName, "Last")
    }
    
    func test_givenWorker_whenServiceMakeAuthCalled_andReturnsSuccessWithNoData_thenProperErrorReturned() {
        let expectation1 = expectation(description: "Wait for makeAuth() to return")
        service.authStatusCodeStub = 200
        service.authRespondeDataStub = DefaultAuthService.Response(authorized: true, user: nil)
        var authError: Error!
        
        sut.makeAuth { result in
            if case .failure(let error) = result {
                authError = error
            }
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(authError.localizedDescription,
                       "The operation couldn’t be completed. (CleanLogin.LoginSceneAuthWorker.LoginSceneAuthWorkerError error 0.)")
    }
    
    func test_givenWorker_whenServiceMakeAuthCalled_andReturnsFailure_thenProperErrorReturned() {
        let expectation1 = expectation(description: "Wait for makeAuth() to return")
        service.authStatusCodeStub = 500
        var authError: Error!
        
        sut.makeAuth { result in
            if case .failure(let error) = result {
                authError = error
            }
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(authError!.localizedDescription,
                       "The operation couldn’t be completed. (CleanLogin.LoginSceneAuthWorker.LoginSceneAuthWorkerError error 1.)")
    }
}

private final class AuthServiceMock: AuthService {
    var authStatusCodeStub: Int!
    var authRespondeDataStub: DefaultAuthService.Response = DefaultAuthService.Response(authorized: false, user: nil)
    
    func auth() -> AnyPublisher<DefaultAuthService.Response, Error> {
        let statusCode: Int = authStatusCodeStub
        
        let request = URLRequest(url: URL(string: "someFaktUrl")!)
        let response
            = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        
        return Deferred {
            Future { promise in
                DispatchQueue.global().asyncAfter(deadline: .now(), execute: {
                    promise(.success((data: Data(), response: response)))
                })
            }
        }
        .setFailureType(to: URLError.self)
        .tryMap({ result in
            self.authRespondeDataStub
        })
        .eraseToAnyPublisher()
    }
}
