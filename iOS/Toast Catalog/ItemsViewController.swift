import UIKit

class ItemsViewController: UITableViewController {
    private lazy var dataSource = makeDataSource()
    private let networkClient = NetworkClient()
    private let imageRepository = ImageRepository()


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseIdentifier)
        tableView.dataSource = dataSource
        
        fetchItems()
    }

    private func fetchItems() {
        networkClient.getItems { [weak self] result in
            switch result {
            case .success(let items):
                self?.update(with: items)
            case .failure(let error):
                print("Failed to fetch items: \(error)")
            }
        }
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Int, Item> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ItemTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? ItemTableViewCell

                if let image = self.imageRepository.image(forItemIdentifier: item.id) {
                                cell?.iconView.image = image
                            }
                
                //cell?.numberLabel.text = "\(item.id)"
                cell?.nameLabel.text = item.name
                cell?.currencyLabel.text = "\(item.price) \(item.currency)"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "M/d/yy, h:mm a"
                let lastSoldDate = dateFormatter.string(from: item.lastSold)
                cell?.lastSoldLabel.text = "\(lastSoldDate)"

                return cell
            }
        )
    }

    func update(with items: [Item], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}
