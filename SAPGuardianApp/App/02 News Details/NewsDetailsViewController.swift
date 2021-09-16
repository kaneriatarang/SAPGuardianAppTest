//
//  NewsDetailsViewController.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import UIKit
import WebKit

//MARK:- News Details View
class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var readOnWebButton: UIButton! {
        didSet {
            readOnWebButton.layer.cornerRadius = 10
        }
    }
    
    var viewModel: NewsDetailsViewModelType = NewsDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bind()
        viewModel.attach(view: self)
        
    }
    
    func bind() {
        viewModel.reloadData = { [weak self] news in
            self?.titleLabel.text = news?.webTitle
            self?.thumbnailImageView.imageFromURL(news?.fields?.thumbnail)
            self?.textView.attributedText = news?.fields?.bodyAttributed
        }
    }
    
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func setUpUI() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        let label = UILabel()
        label.textColor = .white
        label.text = "News Details"
        navigationItem.titleView = label
        addBackButton()
        readOnWebButton.addTarget(self, action: #selector(self.readOnWebTapped(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let _ = self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func readOnWebTapped(_ sender: UIButton) {
        viewModel.openWebURLOnBrowser()
    }
}

extension NewsDetailsViewController: NewsDetailsViewType {
    //MARK:- Navigate to Other APP based on URL
    func openURLOnApp(url: URL) {
        UIApplication.shared.open(url)
    }
}
