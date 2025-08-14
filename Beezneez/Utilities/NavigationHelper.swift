import UIKit

struct NavigationUtil {
    
    /// SwiftUI has no popToRoot functionality in iOS15, and is slightly improved in iOS16 with NavStack
    /// This struct uses popToRootView successfully
    
  static func popToRootView() {
      
      let viewController = UIApplication
          .shared
          .connectedScenes
          .compactMap { ($0 as? UIWindowScene)?.keyWindow }
          .first?.rootViewController
      
      guard let viewController else { return }
      
      if let navigationController = getNavigationController(viewController: viewController) {
          navigationController.popToRootViewController(animated: true)
      }
  }

  static func getNavigationController(viewController: UIViewController) -> UINavigationController? {

    if let navigationController = viewController as? UINavigationController {
      return navigationController
    }

    for childViewController in viewController.children {
      return getNavigationController(viewController: childViewController)
    }

    return nil
  }
}
