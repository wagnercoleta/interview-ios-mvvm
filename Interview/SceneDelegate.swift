import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let httpClient = SessionAdapter()
            let networkManager = NetworkManager(httpClient: httpClient)
            let listContactsService = ListContactService(networkManager: networkManager)
            let viewModel = ListContactsViewModel(contactService: listContactsService)
            let viewController = ListContactsViewController(viewModel: viewModel)
            
            window.rootViewController = UINavigationController(rootViewController: viewController)
            self.window = window
            window.makeKeyAndVisible()
            
        }
    }
}

