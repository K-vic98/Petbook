final class FirebasePetRepo: PetRepo
{
    private var firebazeIntercalation: FirebazeIntercalation?
    private(set) var pets: Set<Pet> = []
    
    init()
    {
        firebazeIntercalation = container.resolve(FirebazeIntercalation.self)
    }
    
    subscript(id: ID) -> Pet?
    {
        pets.first { $0.id == id }
    }
    
    subscript(sympathyFor id: ID) -> Bool?
    {
        get
        {
            self[id]?.sympathy
        }
        set
        {
            if var newPet = self[id]
            {
                let pet = pets.firstIndex(of: self[id]!)
                pets.remove(at: pet!)
                
                newPet.sympathy = newValue
                pets.insert(newPet)
            }
            
            guard let firebaze = firebazeIntercalation else { return }
            
            Task
            {
                try await firebaze.setSympathy(petWithId: id, sympathy: newValue!)
            }
        }
    }
    
    func bootstrap()
    {
        guard let firebaze = firebazeIntercalation else { return }
        
        Task
        {
            pets = try await firebaze.getAllPets() ?? []
        }
    }
}
