import UIKit

final class SympathiesViewController: UITableViewController
{
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
        title = "Sympathies"
        tableView.register(cellType: SympathyViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return petsData?.showFavoritePets() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: SympathyViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        guard let safePet = petsData?.showPet(index: indexPath.row, currentStatus: .yes) else
        {
            return UITableViewCell()
        }
        
        cell.changePresentetion(image: safePet.photos[0], text: safePet.name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let description = DescriptionViewController(petIndex: indexPath.row, openingStatus: .yes)
        present(description, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
