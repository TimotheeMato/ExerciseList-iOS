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
    
    public func getAllExercises(completion: @escaping ([Exercise]) -> Void, failure: @escaping () -> Void) {
        provider.request(.getExercises) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = JSON(data: data)
                if json["data"].array != nil {
                    var exerciseList = [Exercise]()
                    for (_, subJson):(String, JSON) in json["data"] {
                        exerciseList.append(Exercise(json: subJson))
                    }
                    completion(exerciseList)
                } else {
                    failure()
                }
                
            case let .failure(error):
                failure()
            }
        }
    }
}
