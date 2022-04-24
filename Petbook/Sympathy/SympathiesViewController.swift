import UIKit

final class SympathiesViewController: UITableViewController
{
    private var petRepo: PetRepo?
    private var favoritePets: [Pet] = []
    
    init()
    {
        petRepo = container.resolve(PetRepo.self)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.register(cellType: SympathyViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let allPets = petRepo?.pets
        favoritePets = Array(allPets?.filter { $0.sympathy == true } ?? [])
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return favoritePets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: SympathyViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        let pet = favoritePets[indexPath.item]
        
        cell.pet = pet
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    {
        let description = DescriptionViewController()
        description.pet = favoritePets[indexPath.item]
        present(description, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let petID = self.favoritePets[indexPath.item].id
            self.petRepo?[sympathyFor: petID] = false
            
            favoritePets.remove(at: indexPath.item)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}
