import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        let tabBarController = UITabBarController()
        
        let accountViewController = AccountViewController()
        accountViewController.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle"), tag: 0)
        
        let petSelectionViewController = UINavigationController(rootViewController: PetSelectionViewController())
        petSelectionViewController.navigationBar.prefersLargeTitles = true
        petSelectionViewController.tabBarItem = UITabBarItem(title: "Pets", image: UIImage(systemName: "hare"), tag: 1)
        
        let sympathiesViewController = UINavigationController(rootViewController: SympathiesViewController())
        sympathiesViewController.navigationBar.prefersLargeTitles = true
        sympathiesViewController.tabBarItem = UITabBarItem(title: "Sympathies", image: UIImage(systemName: "heart"), tag: 2)
        
        tabBarController.setViewControllers([accountViewController, petSelectionViewController, sympathiesViewController], animated: true)
        tabBarController.selectedIndex = 1
        
        window?.windowScene = windowScene
        window?.tintColor = .black
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
