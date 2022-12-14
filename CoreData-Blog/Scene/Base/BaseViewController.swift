//
//  BaseViewController.swift
//  CoreData-Blog
//

//

import UIKit

class BaseViewController: UIViewController
{
    private lazy var indicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.addSubview(indicatorView)
        indicatorView.center = self.view.center
    }
}

extension BaseViewController
{
    func showLoadingView()
    {
        indicatorView.startAnimating()
    }
    
    func hideLoadingView()
    {
        indicatorView.stopAnimating()
    }
    
    func showError(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
