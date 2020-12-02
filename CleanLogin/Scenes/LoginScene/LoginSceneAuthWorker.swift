//
//  LoginSceneAuthWorker.swift
//  CleanLogin
//
//  Created by Patryk Strzemiecki on 01/12/2020.
//

import Foundation
import Combine
import os.log

protocol LoginSceneAuthLogic {
    func makeAuth(
        completion: @escaping (Result<CleanLoginUser, LoginSceneAuthWorker.LoginSceneAuthWorkerError>
        ) -> Void)
}

final class LoginSceneAuthWorker {
    private let service: AuthService
    private var bag = Set<AnyCancellable>()
    private lazy var logger
        = Logger(subsystem: String(describing: self), category: "Worker")
    
    init(service: AuthService) {
        self.service = service
    }
    
    enum LoginSceneAuthWorkerError: Error {
        case authFailed(String)
        case unauthorized
    }
}

extension LoginSceneAuthWorker: LoginSceneAuthLogic {
    func makeAuth(
        completion: @escaping (Result<CleanLoginUser, LoginSceneAuthWorkerError>
        ) -> Void) {
        service.auth()
            .sink { [weak self] status in
                self?.logger.info("status received \(String(describing: status))")
            } receiveValue: { [weak self] value in
                switch value.authorized {
                case true:
                    guard let user = value.user else {
                        completion(.failure(.authFailed("user data empty")))
                        return
                    }
                    let userModel
                        = CleanLoginUser(firstName: user.firstName,
                                         lastName: user.lastName)
                    completion(.success(userModel))
                case false:
                    completion(.failure(.unauthorized))
                }
                self?.logger.info("value received \(String(describing: value))")
            }
            .store(in: &bag)
    }
}
