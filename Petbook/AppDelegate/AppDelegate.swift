import UIKit
import Swinject

internal let container = Container()

@main
final class AppDelegate: UIResponder, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        container.register(FirebazeIntercalation.self)
         { _ in
           return FirebazeIntercalation()
         }.inObjectScope(.container)
        
        container.register(PetDataHandler.self)
         { _ in
           return PetFirebazeDataHandler()
         }.inObjectScope(.container)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
