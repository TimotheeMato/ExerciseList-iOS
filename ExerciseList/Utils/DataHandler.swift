//
//  DataHandler.swift
//  ExerciseList
//
//  Created by Timothee MATO on 11/5/17.
//  Copyright © 2017 TimotheeMato. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class DataHandler {
    let provider = MoyaProvider<ExerciseService>()
    var databaseService: DatabaseService!
    
    public func getAllExercises(completion: @escaping ([Exercise]) -> Void, failure: @escaping () -> Void) {
        do {
            databaseService = try DatabaseService()
            let exerciseListDb = try databaseService.getAllExercises()
            if exerciseListDb.count != 0 {
                completion(exerciseListDb)
            } else {
                provider.request(.getExercises) { result in
                    switch result {
                    case let .success(moyaResponse):
                        let data = moyaResponse.data
                        let json = JSON(data: data)
                        if json["data"].array != nil {
                            var exerciseList = [Exercise]()
                            for (_, subJson):(String, JSON) in json["data"] {
                                let exercise = Exercise(json: subJson)
                                exerciseList.append(exercise)
                                do {
                                    try self.databaseService.storeExercise(exercise: exercise)
                                } catch {
                                    print("Error info: \(error)")
                                }
                            }
                            completion(exerciseList)
                        } else {
                            failure()
                        }
                    case let .failure(_):
                        failure()
                    }
                }
            }
        } catch {
            print("Error info: \(error)")
            failure()
        }
    }
}
