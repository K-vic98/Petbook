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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .done, target: self, action: #selector(openSearchSettings))
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    @IBAction private func dislikePressed(_ sender: UIButton)
    {
        kolodaView.swipe(.left, force: true)
    }
    
    @IBAction private func returnPressed(_ sender: Any)
    {
        kolodaView.revertAction(direction: .up)
    }
    
    @IBAction private func likePressed(_ sender: Any)
    {
        kolodaView.swipe(.right, force: true)
    }
    
    @objc private func openSearchSettings()
    {
        
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
                petsData?.changePetStatus(index: index, currentStatus: .notChosen, futureStatus: .no)
                
            case .right, .topRight, .bottomRight:
                petsData?.changePetStatus(index: index, currentStatus: .notChosen, futureStatus: .yes)
            default: ()
        }
    }
    
    func koloda(_ koloda: KolodaView, didRewindTo index: Int)
    {
        petsData?.changePetStatus(index: index, currentStatus: .yes, futureStatus: .notChosen)
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
        
        guard let safePet = petsData?.showPet(index: index, currentStatus: .notChosen) else
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
