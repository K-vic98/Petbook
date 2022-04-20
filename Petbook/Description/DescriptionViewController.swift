import UIKit
import ZKCarousel

final class DescriptionViewController: UIViewController
{
    @IBOutlet private weak var photos: ZKCarousel!
    @IBOutlet private weak var nameAndSexLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    private let petsData: PetDataHandler?
    
    init(petIndex: Int, openingStatus: Sympathy)
    {
        petsData = container.resolve(PetDataHandler.self)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var slides: [ZKCarouselSlide] = []
        
        guard let safePet = petsData?.showPet() else { return }
        
        for photo in safePet.photos
        {
            slides.append(ZKCarouselSlide(image: photo))
        }
        
        photos.slides = slides
        
        nameAndSexLabel.text = "\(safePet.name) \(safePet.sex.rawValue)"
        ageLabel.text = "\(safePet.age) 🎂"
        descriptionTextView.text = safePet.description
    }
}
