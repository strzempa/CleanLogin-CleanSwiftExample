//
//  ___FILENAME___
//  ___PROJECTNAME___
//

import UIKit

protocol ___VARIABLE_sceneName___SceneViewControllerInput: AnyObject {}

typealias ___VARIABLE_sceneName___SceneViewControllerOutput
    = ___VARIABLE_sceneName___SceneInteractorInput

final class ___VARIABLE_sceneName___SceneViewController: UIViewController {
    var interactor: ___VARIABLE_sceneName___SceneViewControllerOutput?
    var router: ___VARIABLE_sceneName___SceneRoutingLogic?
    
    private let contentView: ___VARIABLE_sceneName___SceneView
    
    init(
        contentView: ___VARIABLE_sceneName___SceneView
            = Default___VARIABLE_sceneName___SceneView()
    ) {
        self.contentView = contentView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        self.view = contentView
    }
}

// swiftlint:disable colon
extension ___VARIABLE_sceneName___SceneViewController:
    ___VARIABLE_sceneName___SceneViewControllerInput {}

// swiftlint:disable colon
extension ___VARIABLE_sceneName___SceneViewController:
    ___VARIABLE_sceneName___SceneViewDelegate {}
