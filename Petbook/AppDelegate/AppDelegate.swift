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
        
        container.register(PetRepo.self)
         { _ in
           return FirebasePetRepo()
         }.inObjectScope(.container)
        
        container.resolve(PetRepo.self)?.bootstrap()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
