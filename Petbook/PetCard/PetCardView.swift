import UIKit
import Reusable

final internal class PetCardView: UIView, NibLoadable
{
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sexLabel: UILabel!
    
    weak var petClickHandlerDelegate: PetClickHandler?
    
    func updatePresentation(avatar: UIImage, age: String, name: String, sex: String)
    {
        avatarImage.image = avatar
        ageLabel.text = age
        nameLabel.text = name
        sexLabel.text = sex
    }
    
    @IBAction private func cardPressed(_ sender: UIButton)
    {
        petClickHandlerDelegate?.openDescription()
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
