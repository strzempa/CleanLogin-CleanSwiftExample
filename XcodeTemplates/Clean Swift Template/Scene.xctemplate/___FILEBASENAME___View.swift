//
//  ___FILENAME___
//  ___PROJECTNAME___
//

import UIKit

protocol ___VARIABLE_sceneName___SceneViewDelegate: AnyObject {}

protocol ___VARIABLE_sceneName___SceneView: UIView {
    var delegate: ___VARIABLE_sceneName___SceneViewDelegate? { get set }
}

// swiftlint:disable colon
final class Default___VARIABLE_sceneName___SceneView:
    UIView, ___VARIABLE_sceneName___SceneView {
    
    weak var delegate: ___VARIABLE_sceneName___SceneViewDelegate?
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI setup
private extension Default___VARIABLE_sceneName___SceneView {
    func setupUI() {}
}
