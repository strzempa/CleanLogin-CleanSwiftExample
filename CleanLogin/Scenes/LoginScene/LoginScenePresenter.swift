//
//  LoginPresenter.swift
//  CleanLogin
//
//  Created by Patryk Strzemiecki on 01/12/2020.
//

import UIKit

typealias LoginScenePresenterInput = LoginInteractorOutput
typealias LoginScenePresenterOutput = LoginSceneViewControllerInput

final class LoginScenePresenter {
    weak var viewController: LoginScenePresenterOutput?
}

extension LoginScenePresenter: LoginScenePresenterInput {
    func showLogingFailure(message: String) {
        dispatchPrecondition(condition: .onQueue(.main))
        let errorMessage: String

        #if DEBUG
        errorMessage = message
        #else
        errorMessage = ""
        #endif
        
        viewController?.showLogingFailure(message: """
            Oops, something failed on our side :(
            \(message)
            """)
    }
    
    func showLogingSuccess(user: CleanLoginUser) {
        dispatchPrecondition(condition: .onQueue(.main))
        viewController?.showLogingSuccess(fullUserName: user.firstName + " " + user.lastName)
    }
}
