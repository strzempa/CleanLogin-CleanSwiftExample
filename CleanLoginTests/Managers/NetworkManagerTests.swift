//
//  NetworkManagerTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
import Combine
@testable import CleanLogin

final class NetworkManagerTests: XCTestCase {
    private var sut: DefaultNetworkManager!
    private var session: MockNetworkSession!
    private var bag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        session = MockNetworkSession()
        sut = DefaultNetworkManager(session: session)
    }
    
    override func tearDown() {
        sut = nil
        session = nil
        
        super.tearDown()
    }
        
    func test_givenNetworkManager_whenPublisherSinkedOnProperEndpoint_andShouldNotAuthorize_thenReturnsNoData() {
        session.shouldAuthorizeStub = false
        let expectation1 = expectation(description: "Wait for publisher to return")
        var completionStatus: Combine.Subscribers.Completion<Swift.Error>!
        var responseData: DefaultAuthService.Response?
        
        publisher(urlString: "nothttps://netguru.com/api/authMeInPlease")
            .sink { status in
                completionStatus = status
            } receiveValue: { value in
                responseData = value
                expectation1.fulfill()
            }
            .store(in: &bag)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertNotNil(responseData)
        XCTAssertEqual(completionStatus.debugDescription, "Optional(Combine.Subscribers.Completion<Swift.Error>.finished)")
    }
    
    func test__givenNetworkManager_whenPublisherSinkedOnProperEndpoint_andShouldAuthorize_thenReturnsNoData() {
        session.shouldAuthorizeStub = true
        let expectation1 = expectation(description: "Wait for publisher to return")
        var completionStatus: Combine.Subscribers.Completion<Swift.Error>!
        var responseData: DefaultAuthService.Response?
        
        publisher(urlString: "nothttps://netguru.com/api/authMeInPlease")
            .sink { status in
                completionStatus = status
            } receiveValue: { value in
                responseData = value
                expectation1.fulfill()
            }
            .store(in: &bag)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertNotNil(responseData)
        XCTAssertEqual(completionStatus.debugDescription, "Optional(Combine.Subscribers.Completion<Swift.Error>.finished)")
    }
    
    func test_givenNetworkManager_whenPublisherSinkedOnBrokenEndpoint_thenReturnsNoData() {
        let expectation1 = expectation(description: "Wait for publisher to return")
        var completionStatus: Combine.Subscribers.Completion<Swift.Error>!
        var responseData: DefaultAuthService.Response?
        
        publisher(urlString: "nothttps://netguru.com/api/brokenEndpoint")
            .sink { status in
                completionStatus = status
                expectation1.fulfill()
            } receiveValue: { value in
                responseData = value
            }
            .store(in: &bag)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertNil(responseData)
        XCTAssertNotNil(completionStatus)
    }
}

private extension NetworkManagerTests {
    func publisher(urlString: String) -> AnyPublisher<DefaultAuthService.Response, Error> {
        sut.publisher(for: URLRequest(url: URL(string: urlString)!))
    }
}
