//
//  LoginInteractor.swift
//  CleanLogin
//
//  Created by Patryk Strzemiecki on 01/12/2020.
//

import Foundation

typealias LoginSceneInteractorInput = LoginSceneViewControllerOutput

protocol LoginInteractorOutput: AnyObject {
    func showLogingSuccess(user: CleanLoginUser)
    func showLogingFailure(message: String)
}

final class LoginSceneInteractor {
    var presenter: LoginScenePresenterInput?
    var authWorker: LoginSceneAuthWorker?
}

extension LoginSceneInteractor: LoginSceneInteractorInput {
    func tryToLogIn() {
        authWorker?.makeAuth(completion: { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    self?.presenter?.showLogingSuccess(user: data)
                case .failure(let error):
                    self?.presenter?.showLogingFailure(message: error.localizedDescription)
                }
            }
        })
    }
}
