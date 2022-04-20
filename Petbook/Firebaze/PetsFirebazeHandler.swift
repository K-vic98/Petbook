final class PetFirebazeDataHandler: PetDataHandler
{
    var index: Int = 0
    var currentPageStatus: Sympathy = .nothing
    
    private var firebazeIntercalation: FirebazeIntercalation?
    
    init()
    {
        firebazeIntercalation = container.resolve(FirebazeIntercalation.self)
    }
    
    func showPetsWithoutStatus() -> Int
    {
        return firebazeIntercalation?.getUnselectedPetsCount() ?? 0
    }
    
    func showFavoritePets() -> Int
    {
        return firebazeIntercalation?.getFavoritePetsCount() ?? 0
    }
    
    func showPet() -> Pet
    {
        return Pet(name: "", sex: .boy, age: 9, description: "", photos: [])
    }
    
    func changePetStatus(currentStatus: Sympathy, futureStatus: Sympathy)
    {
        
    }
}
