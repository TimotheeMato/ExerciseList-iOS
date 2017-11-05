//
//  ExerciseService.swift
//  ExerciseList
//
//  Created by Timothee MATO on 11/5/17.
//  Copyright © 2017 TimotheeMato. All rights reserved.
//

import Foundation
import Moya

enum ExerciseService {
    case getExercises
}

extension ExerciseService: TargetType {
    var baseURL: URL {
        return URL(string: "https://s3-us-west-1.amazonaws.com")!
    }
    
    var path: String {
        switch self {
        case .getExercises:
            return "/fizzup/files/public/sample.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getExercises:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getExercises:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
