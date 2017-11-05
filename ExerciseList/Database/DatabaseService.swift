//
//  DatabaseService.swift
//  ExerciseList
//
//  Created by Timothee MATO on 11/5/17.
//  Copyright © 2017 TimotheeMato. All rights reserved.
//

import Foundation
import SQLite

class DatabaseService {
    var db: Connection!
    
    let exercises = Table("exercises")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let imageUrl = Expression<String>("image_url")

    init() throws {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        db = try Connection("\(path)/exercises.sqlite3")
        try db.run(exercises.create(ifNotExists: true) { table in
            table.column(id, primaryKey: true)
            table.column(name)
            table.column(imageUrl)
        })
    }
    
    func storeExercise(exercise: Exercise) throws {
        let insert = exercises.insert(id <- exercise.id!, name <- exercise.name!, imageUrl <- exercise.imageUrl!)
        try db.run(insert)
    }
    
    func getAllExercises() throws -> [Exercise] {
        var exerciseList = [Exercise]()
        for exercise in try db.prepare(exercises) {
            exerciseList.append(Exercise(id: exercise[id], name: exercise[name], imageUrl: exercise[imageUrl]))
        }
        return exerciseList
    }
}
