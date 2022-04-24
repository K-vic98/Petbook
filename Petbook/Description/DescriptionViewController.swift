import UIKit
import Kingfisher

final class DescriptionViewController: UIViewController
{
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet private weak var nameAndSexLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    var pet: Pet?
    {
        didSet
        {
            loadViewIfNeeded()
            
            guard let pet = pet else { return }
            
            photoImage.kf.setImage(with: pet.photoURL)
            nameAndSexLabel.text = "\(pet.name) \(pet.sex.rawValue)"
            ageLabel.text = "\(pet.age) 🎂"
            descriptionTextView.text = pet.description
        }
    }
}
