//
//  Exercise.swift
//  ExerciseList
//
//  Created by Timothee MATO on 11/5/17.
//  Copyright © 2017 TimotheeMato. All rights reserved.
//

import Foundation
import SwiftyJSON

class Exercise {
    var id: Int?
    var name: String?
    var imageUrl: String?
    
    init(json: JSON) {
        id = json["id"].int
        name = json["name"].string
        imageUrl = json["image_url"].string
    }
    
    init(id: Int, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
