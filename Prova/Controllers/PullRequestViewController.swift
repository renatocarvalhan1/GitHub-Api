//
//  PullRequestViewController.swift
//  Prova
//
//  Created by Renato Carvalhan on 28/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit

class PullRequestViewController: BaseViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var repository: Repository!
    var pullResquests = [PullResquest]()

    var reuseIdentifier = "PullRequestCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Pull Requests"
        
        let webService = WebService.shared
        webService.delegate = self
        webService.getPullResquests(repository: repository)
        
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.frame.width
            flowLayout.estimatedItemSize = CGSize(width: width, height: 181)
        }
    }
    
    @objc func openLinkGitHub(_ sender: UIButton) {
        let cell = sender.superview!.superview!.superview!.superview as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let pullRequest = pullResquests[indexPath.row]
        
        if let url = URL(string: pullRequest.urlPage!) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

extension PullRequestViewController: WebServiceDelegate {
    func requestFinished(entities: [BaseEntity]) {
        pullResquests = entities as! [PullResquest]
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource

extension PullRequestViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pullResquests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PullRequestCell
        
        let pullResquest = pullResquests[indexPath.row]
        
        cell.userNameLabel.text = pullResquest.user!.login
        cell.dateLabel.text = pullResquest.createdAt!.dateToString()
        cell.titleLabel.text = pullResquest.title
        cell.bodyLabel.text = pullResquest.body
        cell.userAvatarView.sd_setImage(with: URL(string: pullResquest.user!.avatarUrl!), placeholderImage: #imageLiteral(resourceName: "user_placeholder"))
        cell.openLinkButton.addTarget(self, action: #selector(openLinkGitHub(_:)), for: .touchUpInside)
        
        if (indexPath.row % 2) == 0 {
            cell.cardView.backgroundColor = UIColor.white
        } else {
            cell.cardView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 255/255, alpha: 1)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension PullRequestViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = cell as! PullRequestCell
        cell.animateIn()
    }
}

extension Date {
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
