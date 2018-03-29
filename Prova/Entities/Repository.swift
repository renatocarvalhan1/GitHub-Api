//
//  Repository.swift
//  Prova
//
//  Created by Renato Carvalhan on 27/03/18.
//  Copyright © 2018 Renato Carvalhan. All rights reserved.
//

import UIKit
import ObjectMapper

class Repository: BaseEntity {
    
    var name: String?
    var desc: String?
    var forksCount: Int?
    var starsCount: Int?
    var owner: Owner?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        name <- map["name"]
        desc <- map["description"]
        forksCount <- map["forks_count"]
        starsCount <- map["stargazers_count"]
        owner <- map["owner"]
    }
}
