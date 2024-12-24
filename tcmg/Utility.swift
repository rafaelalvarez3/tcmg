//
//  Utility.swift
//  tcmg
//
//  Created by Rafael Alvarez on 12/20/24.
//

import Foundation
import CreateML
import TabularData

class Utility {
    /* For reference */
    func printMessage(message: String) -> Void {
        print(message)
    }
    
    /* Begin actual utilities. */
    
    enum UtilityError: Error {
        case fileNotFound
        case fileNameNotEntered
        case fileWrongType
    }
    
    func newJSONDataFrame(JSONFileName: String) throws -> DataFrame {
        let fileURL = URL(fileURLWithPath: JSONFileName)
        
        guard fileURL.pathExtension == "json" else {
            throw UtilityError.fileWrongType
        }

        let data = try DataFrame(contentsOfJSONFile: fileURL)
        return data
    }
}
