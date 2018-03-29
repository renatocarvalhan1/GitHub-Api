//
//  Owner.swift
//  Prova
//
//  Created by Renato Carvalhan on 27/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit
import ObjectMapper

class Owner: BaseEntity {
    
    var login: String?
    var avatarUrl: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        dbId <- map["id"]
        login <- map["login"]
        avatarUrl <- map["avatar_url"]
    }

}
