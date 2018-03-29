//
//  RepositoryViewController.swift
//  Prova
//
//  Created by Renato Carvalhan on 27/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryViewController: BaseViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var repositories = [Repository]()
    var reuseIdentifier = "RepositoryCell"
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub"
        loadRepositories()
        
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.frame.width
            flowLayout.estimatedItemSize = CGSize(width: width, height: 190)
        }
    
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    func loadRepositories() {
        let webService = WebService.shared
        webService.delegate = self
        webService.getRepositories(language: "Java", page: page)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RepositoryToPullRequest" {
            let toView = segue.destination as! PullRequestViewController
            let repository = sender as! Repository
            toView.repository = repository
        }
    }
}

// MARK: WebServiceDelegate

extension RepositoryViewController: WebServiceDelegate {
    
    func requestFinished(entities: [BaseEntity]) {
        repositories.append(contentsOf: entities as! [Repository])
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource

extension RepositoryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RepositoryCell
        
        let repository = repositories[indexPath.row]
        
        cell.ownerNameLabel.text = repository.owner!.login
        cell.nameLabel.text = repository.name
        cell.descLabel.text = repository.desc
        cell.forksCountLabel.text = String(describing: repository.forksCount!)
        cell.starsCountLabel.text = String(describing: repository.starsCount!)
        cell.ownerAvatarView.sd_setImage(with: URL(string: repository.owner!.avatarUrl!), placeholderImage: #imageLiteral(resourceName: "user_placeholder"))
        
        if (indexPath.row % 2) == 0 {
            cell.cardView.backgroundColor = UIColor.white
        } else {
            cell.cardView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension RepositoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        // Animate 3D scale
        let cell = cell as! RepositoryCell
        cell.animateIn()
        
        // Load more Repositories
        if indexPath.row == repositories.count - 1 {
            page += 1
            loadRepositories()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        performSegue(withIdentifier: "RepositoryToPullRequest", sender: repository)
    }
}
