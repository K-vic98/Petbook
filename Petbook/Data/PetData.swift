import UIKit

struct Pet: Hashable
{
    typealias ID = String
    
    let id: ID
    var sympathy: Bool?
    
    let name: String
    let sex: Sex
    let age: Int
    let description: String
    let photoURL: URL
}

enum Sex: String
{
    case boy = "♂"
    case girl = "♀"
    
    init(_ isBoy: Bool)
    {
        self = isBoy == true ? .boy : .girl
    }
}

protocol PetRepo
{
    typealias ID = Pet.ID
    
    var pets: Set<Pet> { get }
    subscript(_ id: ID) -> Pet? { get }
    subscript(sympathyFor id: ID) -> Bool? { get set }
    
    func bootstrap()
}
