//
//  DataHandler.swift
//  ExerciseList
//
//  Created by Timothee MATO on 11/5/17.
//  Copyright © 2017 TimotheeMato. All rights reserved.
//

import Foundation
import Moya

class DataHandler {
    let provider = MoyaProvider<ExerciseService>()
    
    public func getAllExercises() {
        provider.request(.getExercises) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let data = try moyaResponse.mapJSON()
                    print("\(data)")
                } catch {
                    print("Error")
                }
            case let .failure(error):
                break
            }
        }
    }
}
