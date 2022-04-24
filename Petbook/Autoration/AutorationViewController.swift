import UIKit
import Firebase

final class AutorationViewController: UIViewController
{
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private var firebazeIntercalation: FirebazeIntercalation?
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        firebazeIntercalation = container.resolve(FirebazeIntercalation.self)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func LoginPressed(_ sender: UIButton)
    {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Task
        {
            try await firebazeIntercalation?.authorizeUser(email: login, password: password)
            await MainActor.run
            {
                UIApplication.shared.keyWindow?.rootViewController = openTabBarController()
            }
        }
    }
    
    @IBAction private func RegisterPressed(_ sender: UIButton)
    {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Task
        {
            try await firebazeIntercalation?.registerUser(email: login, password: password)
        }
    }
    
    private func openTabBarController() -> UITabBarController
    {
        let tabBarController = UITabBarController()
        
        let accountViewController = AccountViewController()
        accountViewController.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle"), tag: 0)
        
        let petSelectionViewController = PetSelectionViewController()
        petSelectionViewController.tabBarItem = UITabBarItem(title: "Pets", image: UIImage(systemName: "hare"), tag: 1)
        
        let sympathiesViewController = SympathiesViewController()
        sympathiesViewController.tabBarItem = UITabBarItem(title: "Sympathies", image: UIImage(systemName: "heart"), tag: 2)
        
        tabBarController.setViewControllers([accountViewController, petSelectionViewController, sympathiesViewController], animated: true)
        tabBarController.selectedIndex = 1
        
        return tabBarController
    }
}
