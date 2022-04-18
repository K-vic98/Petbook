import UIKit
import Reusable

final class SympathyViewCell: UITableViewCell, NibReusable
{
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    func changePresentetion(image: UIImage, text: String)
    {
        avatarImage.image = image
        nameLabel.text = text
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
