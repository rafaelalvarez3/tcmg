//
//  Utility.swift
//  tcmg
//
//  Created by Rafael Alvarez on 12/20/24.
//

import Foundation
import CreateML
import TabularData

extension Main {
    enum UtilityError: Error {
        case fileWrongType
    }

    func newCSVDataFrame(_ CSVFileName: String) throws -> DataFrame {
        let fileURL = URL(fileURLWithPath: CSVFileName)
        guard fileURL.pathExtension == "csv" else {
            throw UtilityError.fileWrongType
        }
        let data = try DataFrame(contentsOfCSVFile: fileURL)
        return data
    }
}
