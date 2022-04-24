import UIKit
import Reusable
import Kingfisher

final internal class PetCardView: UIView, NibLoadable
{
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sexLabel: UILabel!
    
    weak var petClickHandlerDelegate: PetClickHandler?
    
    var pet: Pet?
    {
        didSet
        {
            guard let pet = pet else { return }
            
            avatarImage.kf.setImage(with: pet.photoURL)
            ageLabel.text = String(pet.age)
            nameLabel.text = pet.name
            sexLabel.text = pet.sex.rawValue
        }
    }
    
    @IBAction private func cardPressed(_ sender: UIButton)
    {
        petClickHandlerDelegate?.openDescription(pet: pet ?? nil)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        decorate(label: ageLabel, cornerRadius: ageLabel.bounds.height / 2)
        decorate(label: nameLabel, cornerRadius: 4)
        decorate(label: sexLabel, cornerRadius: sexLabel.bounds.height / 2)
    }
    
    private func decorate(label: UILabel, cornerRadius: CGFloat)
    {
        label.layer.cornerRadius = cornerRadius
        label.layer.masksToBounds = true
        label.layer.borderWidth = 7
        label.layer.borderColor = UIColor.black.cgColor
    }
}
