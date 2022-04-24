import UIKit
import Reusable
import Kingfisher

final class SympathyViewCell: UITableViewCell, NibReusable
{
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var pet: Pet?
    {
        didSet
        {
            guard let pet = pet else { return }
            
            avatarImage.kf.setImage(with: pet.photoURL)
            nameLabel.text = pet.name
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.borderWidth = 2
        avatarImage.layer.borderColor = UIColor.black.cgColor
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
