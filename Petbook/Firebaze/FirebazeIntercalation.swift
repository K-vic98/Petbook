import Firebase
import FirebaseFirestore

let petsFirestore = "pets"
let userPetsFirestore = "userPets"
let favoritePetsKey = "favorite"
let unwantedPetsKey = "unwanted"

final class FirebazeIntercalation
{
    private let userPets: CollectionReference?
    private let pets: CollectionReference?
    
    private var favoriteUserPets: [String] = []
    private var unwantedUserPets: [String] = []
    private var unselectedPets: [String] = []
    
    init()
    {
        FirebaseApp.configure()
        let dataBaze = Firestore.firestore()
        
        pets = dataBaze.collection(petsFirestore)
        userPets = dataBaze.collection(userPetsFirestore)
    }
    
    func authorizeUser(email: String, password: String) -> String?
    {
        var errorMessage: String?
        
        Auth.auth().signIn(withEmail: email, password: password)
        { [weak self] authResult, error in
            guard let actualyError = error else
            {
                guard let userID = Auth.auth().currentUser?.uid else { return }
                let userChoice = self?.userPets?.document(userID)
                
                userChoice?.getDocument
                { [weak self] documentSnapshot, error in
                    guard let document = documentSnapshot else { return }
                    
                    if document.exists == true
                    {
                        self?.getUnselectedPets()
                    }
                    else
                    {
                        self?.userPets?.document(userID).setData(["favorite": [], "unwanted": []])
                    }
                }
                
                return
            }
            
            errorMessage = actualyError.localizedDescription
        }
        
        return errorMessage
    }
    
    func registerUser(email: String, password: String) -> String?
    {
        var errorMessage: String?
        
        Auth.auth().createUser(withEmail: email, password: password)
        { authResult, error in
            guard let actualyError = error else
            {
               return
            }
            
            errorMessage = actualyError.localizedDescription
        }
        
        return errorMessage
    }
    
    func getUnselectedPetsCount() -> Int
    {
        return unselectedPets.count
    }
    
    func getFavoritePetsCount() -> Int
    {
        return favoriteUserPets.count
    }
    
    func showPetInformation()
    {
        let pet = userPets?.document(unselectedPets[0])
        
        pet?.getDocument()
        { (document, error) in
            guard let safeDocument = document else { return }
            //let commentItem = PetFirebazeDocument(snapshot: safeDocument.data())
        }
    }
    
    func addPetToUser()
    {
        
    }
    
    private func getUnselectedPets()
    {
        getUserFavoritePets()
        getUserUnwantedPets()
        
        let petsWithStatus = favoriteUserPets + unwantedUserPets
        
        pets?.getDocuments(completion:
        { [weak self] querySnapshot, error in
            guard let query = querySnapshot else { return }
            
            let documents = query.documents
            
            for document in documents
            {
                self?.unselectedPets.append(document.documentID)
            }
        })
        
        unselectedPets = Array(Set(unselectedPets).subtracting(petsWithStatus))
    }
    
    private func getUserFavoritePets()
    {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let userChoice = userPets?.document(userID)
        
        userChoice?.getDocument
        { [weak self] (documentSnapshot, error) in
            guard let document = documentSnapshot else { return }
            let documentData = document.data()
            self?.favoriteUserPets = documentData?[favoritePetsKey] as? [String] ?? []
        }
    }
    
    private func getUserUnwantedPets()
    {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let userChoice = userPets?.document(userID)
        
        userChoice?.getDocument
        { [weak self] (documentSnapshot, error) in
            guard let document = documentSnapshot else { return }
            let documentData = document.data()
            self?.unwantedUserPets = documentData?[unwantedPetsKey] as? [String] ?? []
        }
    }
}

struct PetFirebazeDocument
{
    var documentId : String?
    let age: Int?
    let description: String?
    let name: String?
    let photosLink: String?
    let sex: Bool?
    
    var dictionary : [String:Any]
    {
        return [
                "age": age  ?? 0,
                "description": description  ?? "",
                "name": name  ?? "",
                "photosLink": photosLink  ?? "",
                "sex": sex  ?? false
               ]
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        documentId = snapshot.documentID
        let snapshotValue = snapshot.data()
        age = snapshotValue["age"] as? Int
        description = snapshotValue["description"] as? String
        name = snapshotValue["name"] as? String
        photosLink = snapshotValue["photosLink"] as? String
        sex = snapshotValue["sex"] as? Bool
    }
}
