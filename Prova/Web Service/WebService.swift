//
//  WebService.swift
//  Prova
//
//  Created by Renato Carvalhan on 27/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

@objc protocol WebServiceDelegate {
    
    /// When no response needs to be handled
    @objc optional func requestFinished() -> Void
    /// When a single object needs to be handled
    @objc optional func requestFinished(entity: BaseEntity) -> Void
    /// When an array of objects needs to be handled
    @objc optional func requestFinished(entities: [BaseEntity]) -> Void
    /// When a response without mapping needs to be handled
    @objc optional func requestFinished(response: [String : Any]) -> Void
    /// Error
    @objc optional func requestFailed(error: NSError) -> Void
}

class WebService: NSObject {
    var delegate: WebServiceDelegate?
    static var shared = WebService()
    
    private let appDelegate: AppDelegate = {
        UIApplication.shared.delegate as! AppDelegate
    }()
    
    // Repository
    
    func getRepositories(language: String, page: Int) {
        let url = "\(appDelegate.baseUrl)/search/repositories"
        
        Alamofire.request(url, parameters: ["q": "language:\(language)", "sort": "stars", "page": page], encoding: URLEncoding.default).validate()
            .responseArray(keyPath: "items") { (response: DataResponse<[Repository]>) in
            switch response.result {
            case .success:
                self.delegate?.requestFinished!(entities: response.result.value! )
                
            case .failure(let error):
                self.handleError(aError: error as NSError, request: response.request!)
            }
        }
    }
    
    // PullRequest
    
    func getPullResquests(repository: Repository) {
        let url = "\(appDelegate.baseUrl)/repos/\(repository.owner!.login!)/\(repository.name!)/pulls"
        
        Alamofire.request(url).responseArray { (response: DataResponse<[PullResquest]>) in
            switch response.result {
            case .success:
                self.delegate?.requestFinished!(entities: response.result.value!)
                
            case .failure(let error):
                self.handleError(aError: error as NSError, request: response.request!)
            }
        }
    }
    
    // MARK: - Error handling
    
    private func handleError(aError: NSError, request: URLRequest) {
        // See: http://nshipster.com/nserror/ # CFURLConnection & CFURLProtocol Errors
        switch aError._code {
        case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
            self.appDelegate.showDefaultAlert(title: "Ops!", message: "Sem conexão com a internet")
            return
        case NSURLErrorTimedOut:
            self.appDelegate.showDefaultAlert(title: "Ops!", message: "Não houve resposta do servidor. Tente novamente.")
            return
        default:
            break
        }
    }
}
