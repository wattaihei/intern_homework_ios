//
//  Search.swift
//  intern_homework
//
//  Created by 渡辺泰平 on 2020/08/08.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchArticles()
    }
    
    // make button rich
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchButton.frame = CGRect(x: (self.view.frame.size.width / 2) - 50, y: (self.view.frame.size.height / 2) - 15, width: 100, height: 30)
        searchButton.tintColor = UIColor.black
        searchButton.backgroundColor = UIColor.cyan
        searchButton.layer.borderColor = UIColor.gray.cgColor
        searchButton.layer.borderWidth = 5.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLabel.isHidden = true
        textBox.delegate = self
    }
    
    // close keyboard when pushed "Done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textBox.resignFirstResponder()
        return true
    }
    // close keyboard when tapped screen
    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func searchArticles() {
        searchButton.isEnabled = false
        errorMessageLabel.isHidden = true
        
        guard let text = textBox.text, !text.isEmpty else {
            errorMessageLabel.isHidden = false
            errorMessageLabel.text = "検索ワードを入力してください"
            searchButton.isEnabled = true
            return
        }
        
        APIClient.fetchArticles(keyword: text) {[weak self] result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let articles):
                    self?.showArticleListScreen(articles)
                    
                case .failure(let error):
                    let alert = UIAlertController.createErrorAlert(error)
                    self?.present(alert, animated: true)
                }
                self?.searchButton.isEnabled = true
            }
        }
    }
    
    private func showArticleListScreen(_ articles: [Article]) {
        let articleListViewController = ArticleListViewController.makeInstance(articles)
        navigationController?.pushViewController(articleListViewController, animated: true)
    }
}
