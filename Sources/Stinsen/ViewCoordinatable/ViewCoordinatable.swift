import Foundation
import SwiftUI

///The ViewCoordinatable represents a view with routes that can be switched to but not pushed or presented modally. This can be used if you have a need to switch between different "modes" in the app, for instance if you switch between logged in and logged out. The ViewCoordinatable will recreate the view and the coordinator, so it is not suited to replace a tab-bar or similar modes of navigation, where you want to preserve the state.
public protocol ViewCoordinatable: Coordinatable {
    associatedtype Route: ViewRoute
    associatedtype Start: View
    func resolveRoute(route: Route) -> AnyCoordinatable
    @ViewBuilder func start() -> Start
    var children: ViewChild { get }
}

public extension ViewCoordinatable {
    var childCoordinators: [AnyCoordinatable] {
        return [children.childCoordinator].compactMap { $0 }
    }
    
    var childDismissalAction: DismissalAction {
        get {
            children.childDismissalAction
        } set {
            children.childDismissalAction = newValue
        }
    }
    
    var appearingMetadata: AppearingMetadata? {
        return nil
    }
    
    func coordinatorView() -> AnyView {
        return AnyView(
            ViewCoordinatableView(coordinator: self)
        )
    }
    
    func dismissChildCoordinator(_ childCoordinator: AnyCoordinatable, _ completion: (() -> Void)?) {
        fatalError("not implemented")
    }
}
