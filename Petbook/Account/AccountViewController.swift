import UIKit

final class AccountViewController: UIViewController
{
    @IBOutlet weak var userEmailLabel: UILabel!
    
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
    
    override func viewDidLoad()
    {
        view.backgroundColor = .white
        guard let userEmail = firebazeIntercalation?.getUserEmail() else { return }
        userEmailLabel.text = userEmail
    }
    
    @IBAction func logOut(_ sender: Any)
    {
        firebazeIntercalation?.logOut()
        UIApplication.shared.keyWindow?.rootViewController = AutorationViewController()
    }
}
