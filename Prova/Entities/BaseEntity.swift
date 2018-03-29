//
//  BaseEntity.swift
//  Prova
//
//  Created by Renato Carvalhan on 27/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseEntity: NSObject, Mappable {
    
    var dbId: String?
    var createdAt: Date?
    
    lazy var appDelegate: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
    }

}
