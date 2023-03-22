//
//  GameEntity.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 26/02/23.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Double = 0
    @objc dynamic var released: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

