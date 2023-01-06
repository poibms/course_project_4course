//
//  ViewController.swift
//  CoreData-Blog
//

//

import UIKit

// MARK: - Initialize HomeViewController
final class HomeViewController: BaseViewController
{
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: HomeViewModelProtocol!
    private var paginatedArticles: [Article] = []
    private var fetchOffset = 0
    private var currentArticlesCount: Int?
    
    // MARK: - Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureUI()

        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "door.left.hand.open"),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(exitButtonTapped)), animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        viewModel.removeStoredArticles()
        fetchOffset = 0
        viewModel.loadPaginatedArticles(with: fetchOffset)
    }
}

// MARK: - Configure
extension HomeViewController
{
    @objc
    func exitButtonTapped() {
        let alert = UIAlertController(title: "Quit?",
                                      message: "Are you sure?",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    private func configureUI()
    {
        configureTableView()
        configureViewModel()
    }
    
    private func configureTableView()
    {
        tableView.register(nibName: K.TableView.homeNibName, cell: K.TableView.homeCell)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func configureViewModel()
    {
        viewModel.delegate = self
    }
}

// MARK: - IBActions
extension HomeViewController
{
    @IBAction private func addButtonPressed(_ sender: UIBarButtonItem)
    {
        viewModel.selectAddButton()
    }
}

// MARK: - View Model's Delegate
extension HomeViewController: HomeViewModelDelegate
{
    func handleOutput(_ output: HomeViewModelOutput)
    {
        switch output {
        case .paginatedArticles((let articles, let count)):
            self.paginatedArticles = articles
            self.currentArticlesCount = count
            tableView.reloadData()
        case .showError(let error):
            self.showError(title: "Error", message: error.localizedDescription)
        case .isFavorited((let article, let isFavorite)):
            NotificationBannerManager
                .shared
                .createNotification(with: isFavorite, selectedArticle: article)
        }
    }
    
    func navigate(to route: HomeViewModelRouter)
    {
        switch route {
        case .add(let addViewModel):
            let viewController = AddArticleBuilder.make(viewModel: addViewModel)
            
            show(viewController, sender: nil)
        case .detail(let article,
                     let detailViewModel):
            let viewController = DetailBuilder.make(with: article, detailViewModel)
            
            show(viewController, sender: nil)
        }
    }
}

// MARK: - UITableView Data-Source
extension HomeViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return paginatedArticles.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableView.homeCell,
                                                 for: indexPath) as! HomeTableViewCell
        let article = paginatedArticles[indexPath.row]
        cell.configureCell(with: article)
        cell.delegate = self
        cell.id = article.id
        cell.isFavorite = article.isFavorite

        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell else { return nil }

        if UserDefaults.standard.string(forKey: "login") == cell.getUserName() {
            let action = UIContextualAction(style: .normal, title: "Delete") { action, sourceView, completionHandler in
                self.viewModel.removeArticle(with: cell.getArticleName())
                completionHandler(true)
                DispatchQueue.main.async {
                    self.paginatedArticles.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
            action.backgroundColor = .red

            return UISwipeActionsConfiguration(actions: [action])
        } else { return nil }
    }
}

// MARK: - UITableView Delegate
extension HomeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        let article = paginatedArticles[indexPath.row]
        
        viewModel.selectedArticle(article: article)
    }
}

// MARK: - UITableViewCell Delegate
extension HomeViewController: IHomeTableViewCell
{
    func bookMarkButtonWillPressed(on cell: HomeTableViewCell,
                                   with id: UUID)
    {
        viewModel.addFavorites(with: id)
    }
}

// MARK: - UIScrollView
extension HomeViewController
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool)
    {
        let currentOffset: CGFloat = scrollView.contentOffset.y
        let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
     
        if maximumOffset - currentOffset <= 50
        {
            if paginatedArticles.count >= 5 &&
               paginatedArticles.count != currentArticlesCount
            {
                fetchOffset += 5
                viewModel.loadPaginatedArticles(with: fetchOffset)
            }
        }
    }
}
