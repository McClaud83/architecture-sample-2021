import UIKit
import ScenesCoordinator

extension AppDelegate {
    func beginUserStory() {
        let window = UIWindow()
        self.window = window
        AppRouterImpl().showLoadingScene()
    }
}
