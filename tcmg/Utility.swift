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

    func newCSVFileURL(_ CSVFilePath: String) throws -> URL {
        let fileURL = URL(fileURLWithPath: CSVFilePath)
        guard fileURL.pathExtension == "csv" else {
            throw UtilityError.fileWrongType
        }
        return fileURL
    }
}
