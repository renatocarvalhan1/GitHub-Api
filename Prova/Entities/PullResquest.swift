//
//  PullResquest.swift
//  Prova
//
//  Created by Renato Carvalhan on 27/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import Foundation
import ObjectMapper

class PullResquest: BaseEntity {
    
    var title: String?
    var body: String?
    var urlPage: String?
    var user: Owner?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        title <- map["title"]
        body <- map["body"]
        urlPage <- map["html_url"]
        createdAt <- (map["created_at"], DateTransform())
        user <- map["user"]
    }
}
