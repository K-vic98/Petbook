import UIKit
import Koloda

final class PetSelectionViewController: UIViewController
{
    @IBOutlet private weak var kolodaView: KolodaView!
    
    private var petRepo: PetRepo?
    private let petsWithoutData: [Pet]
    
    init()
    {
        petRepo = container.resolve(PetRepo.self)
        petsWithoutData = Array(petRepo?.pets.filter( { pet in pet.sympathy == nil }) ?? [])
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
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
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection)
    {
        let petID = petsWithoutData[index].id
        
        switch direction
        {
            case .left, .topLeft, .bottomLeft:
                petRepo?[sympathyFor: petID] = false
                
            case .right, .topRight, .bottomRight:
                petRepo?[sympathyFor: petID] = true
                
            default: ()
        }
    }
}

extension PetSelectionViewController: KolodaViewDataSource
{
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int
    {
        return petsWithoutData.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed
    {
        return .slow
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView
    {
        let petCard = PetCardView.loadFromNib()
        petCard.petClickHandlerDelegate = self
        
        let petID = petsWithoutData[index].id
        
        guard let pet = petRepo?[petID] else { return UIView() }
        
        petCard.pet = pet
        
        return petCard
    }
}

extension PetSelectionViewController: PetClickHandler
{
    func openDescription(pet: Pet?)
    {
        guard let pet = pet else { return }
        
        let descriptionViewController = DescriptionViewController()
        descriptionViewController.pet = pet
        
        present(descriptionViewController, animated: true)
    }
}

protocol PetClickHandler: AnyObject
{
    func openDescription(pet: Pet?)
}
