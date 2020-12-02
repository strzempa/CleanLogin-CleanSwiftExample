//
//  ViewController.swift
//  CleanLogin
//
//  Created by Patryk Strzemiecki on 01/12/2020.
//

import UIKit
import os.log

protocol LoginSceneViewControllerInput: AnyObject {
    func showLogingSuccess(fullUserName: String)
    func showLogingFailure(message: String)
}

protocol LoginSceneViewControllerOutput: AnyObject {
    func tryToLogIn()
}

final class LoginSceneViewController: UIViewController {
    var interactor: LoginSceneInteractorInput?
    var router: LoginSceneRoutingLogic?
    
    private lazy var logger = Logger(subsystem: String(describing: self), category: "UI")
    
    private var loginButton: UIButton = {
        let btn = UIButton(frame: CGRect.zero)
        btn.setTitle("Login".uppercased(), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension LoginSceneViewController {
    func setupUI() {
        view.backgroundColor = .systemPink
        setupLoginButton()
    }
    
    func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
    }
    
    @objc func loginButtonAction() {
        interactor?.tryToLogIn()
    }
}

extension LoginSceneViewController: LoginSceneViewControllerInput {
    func showLogingSuccess(fullUserName: String) {
        logger.info("logged: \(fullUserName)")
        router?.showLoginSuccess()
    }
    
    func showLogingFailure(message: String) {
        logger.error("login failure: \(message)")
        router?.showLogingFailure(message: message)
    }
}
