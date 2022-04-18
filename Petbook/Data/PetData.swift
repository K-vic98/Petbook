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
}

protocol PetDataHandler
{
    func showPetsWithoutStatus() -> Int
    func showFavoritePets() -> Int
    func showPet(index: Int, currentStatus: Sympathy) -> Pet
    func changePetStatus(index: Int, currentStatus: Sympathy, futureStatus: Sympathy)
}
