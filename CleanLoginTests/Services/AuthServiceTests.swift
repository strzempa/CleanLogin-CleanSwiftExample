//
//  AuthServiceTests.swift
//  CleanLoginTests
//
//  Created by Patryk Strzemiecki on 02/12/2020.
//

import XCTest
import Combine
@testable import CleanLogin

final class AuthServiceTests: XCTestCase {
    private var sut: AuthService!
    private var networkManager: NetworkManagerMock!
    private var session: MockNetworkSession!
    private var bag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        session = MockNetworkSession()
        networkManager = NetworkManagerMock(session: session)
        sut = DefaultAuthService(networkManager: networkManager)
    }
    
    override func tearDown() {
        sut = nil
        networkManager = nil
        
        super.tearDown()
    }
    
    func test_givenAuthService_whenAuthCalled_thenReturnsSomeData() {
        let expectation1 = expectation(description: "Wait for auth to return")
        var completionStatus: Combine.Subscribers.Completion<Swift.Error>!
        var responseData: DefaultAuthService.Response?
        
        sut.auth()
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
}

private final class NetworkManagerMock: NetworkManager {
    var session: NetworkSession
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func publisher<T>(for request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        session
            .publisher(for: request)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
