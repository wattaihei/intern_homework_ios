//
//  Search.swift
//  intern_homework
//
//  Created by 渡辺泰平 on 2020/08/08.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchArticles()
    }
    
    private func searchArticles() {
        searchButton.isEnabled = false
        
        guard let text = textBox.text, !text.isEmpty else {
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
