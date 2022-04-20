import UIKit

struct Pet
{
    let name: String
    let sex: Sex
    let age: Int
    let description: String
    let photos: [UIImage]
}

enum Sex: String
{
    case boy = "♂"
    case girl = "♀"
}

enum Sympathy
{
    case notChosen
    case no
    case yes
    case nothing
}

protocol PetDataHandler
{
    var index: Int { get set }
    var currentPageStatus: Sympathy { get set }
    
    func showPetsWithoutStatus() -> Int
    func showFavoritePets() -> Int
    func showPet() -> Pet
    func changePetStatus(currentStatus: Sympathy, futureStatus: Sympathy)
}
