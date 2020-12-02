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
    
    struct Resp: Decodable {}
    
    func test_givenNetworkManager_whenPublisherCreated_thenReturnsStatusOnSink() {
        let expectation1 = expectation(description: "Wait for publisher to return")
        var completion: Combine.Subscribers.Completion<Swift.Error>!
        
        publisher().sink { status in
            completion = status
        } receiveValue: { _ in
            expectation1.fulfill()
        }.store(in: &bag)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(completion.debugDescription, "Optional(Combine.Subscribers.Completion<Swift.Error>.finished)")
    }
    
    func publisher() -> AnyPublisher<Resp, Error> {
        sut.publisher(for: URLRequest(url: URL(string: "nothttps://netguru.com/api/authMeInPlease")!))
    }
}
