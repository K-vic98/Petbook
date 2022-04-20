import UIKit
import Koloda

final class PetSelectionViewController: UIViewController
{
    @IBOutlet private weak var kolodaView: KolodaView!
    
    private var petsData: PetDataHandler?
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        petsData = container.resolve(PetDataHandler.self)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Pets"
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        petsData?.currentPageStatus = .notChosen
    }
    
    @IBAction private func dislikePressed(_ sender: UIButton)
    {
        kolodaView.swipe(.left, force: true)
    }
    
    @IBAction private func likePressed(_ sender: Any)
    {
        kolodaView.swipe(.right, force: true)
    }
}

extension PetSelectionViewController: KolodaViewDelegate
{
    func kolodaDidRunOutOfCards(_ koloda: KolodaView)
    {
        
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection)
    {
        switch direction
        {
            case .left, .topLeft, .bottomLeft:
                petsData?.index = index
                petsData?.changePetStatus(currentStatus: .notChosen, futureStatus: .no)
                
            case .right, .topRight, .bottomRight:
                petsData?.changePetStatus(currentStatus: .notChosen, futureStatus: .yes)
            default: ()
        }
    }
    
    func koloda(_ koloda: KolodaView, didRewindTo index: Int)
    {
        petsData?.index = index
        petsData?.changePetStatus(currentStatus: .yes, futureStatus: .notChosen)
    }
}

extension PetSelectionViewController: KolodaViewDataSource
{
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int
    {
        return petsData?.showPetsWithoutStatus() ?? 0
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed
    {
        return .slow
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView
    {
        let petCard = PetCardView.loadFromNib()
        petCard.petClickHandlerDelegate = self
        
        petsData?.index = index
        
        guard let safePet = petsData?.showPet() else
        {
            return UIView()
        }
        
        petCard.updatePresentation(avatar: safePet.photos.first!, age: "\(safePet.age) 🎂", name: safePet.name, sex: safePet.sex.rawValue)
        
        return petCard
    }
}

extension PetSelectionViewController: PetClickHandler
{
    func openDescription()
    {
        let descriptionViewController = DescriptionViewController(petIndex: kolodaView.currentCardIndex, openingStatus: .notChosen)
        present(descriptionViewController, animated: true)
    }
}

protocol PetClickHandler: AnyObject
{
    func openDescription()
}
