import UIKit
import Firebase
import FirebaseFirestore

let petsFirestore = "pets"
let userPetsFirestore = "userPets"

final class FirebazeIntercalation
{
    private let userPets: CollectionReference
    private let pets: CollectionReference
    private var userUid: String?
    
    init()
    {
        FirebaseApp.configure()
        
        let dataBaze = Firestore.firestore()
        
        pets = dataBaze.collection(petsFirestore)
        userPets = dataBaze.collection(userPetsFirestore)
        userUid = Auth.auth().currentUser?.uid
    }
    
    // MARK: User registration and authorization
    
    func registerUser(email: String, password: String) async throws
    {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func authorizeUser(email: String, password: String) async throws
    {
        let authorization = try await Auth.auth().signIn(withEmail: email, password: password)
        
        let userId = authorization.user.uid
        userUid = userId
        
        let userChoice = userPets.document(userId)
        let userChoiceDocument = try await userChoice.getDocument()
        
        if userChoiceDocument.exists == false
        {
            try await userChoice.setData(["0" : false])
        }
    }
    
    func getUserEmail() -> String?
    {
        return Auth.auth().currentUser?.email
    }
    
    func logOut()
    {
        do
        {
            try Auth.auth().signOut()
        }
        catch
        {
            
        }
    }
    
    // MARK: Receiving the information
    
    func getAllPets() async throws -> Set<Pet>?
    {
        let petDocuments = try await pets.getDocuments().documents
        
        var userChoice: DocumentSnapshot?
        
        if let userID = userUid
        {
            userChoice = try await userPets.document(userID).getDocument()
        }
        
        var pets: Set<Pet> = []
        
        for petDocument in petDocuments
        {
            let id = petDocument.documentID
            
            guard let name = petDocument["name"] as? String else { return nil }
            guard let isBoy = petDocument["isBoy"] as? Bool else { return nil }
            guard let age = petDocument["age"] as? Int else { return nil }
            guard let description = petDocument["description"] as? String else { return nil }
            guard let photo = petDocument["photo"] as? String else { return nil }
            
            guard let photoURL = URL(string: photo) else { return nil }
            
            let sympathy = userChoice?[petDocument.documentID] as? Bool
            let sex = Sex(isBoy)
            
            pets.insert(Pet(id: id, sympathy: sympathy, name: name, sex: sex, age: age, description: description, photoURL: photoURL))
        }
        
        return pets
    }
    
    // MARK: Information update
    
    func setSympathy(petWithId: String, sympathy: Bool) async throws
    {
        guard let userUid = userUid else { return }
        
        try await userPets.document(userUid).updateData([petWithId as NSString: sympathy])
    }
}
