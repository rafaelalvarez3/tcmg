//  Utility.swift
//  tcmg
//  Created by Rafael Alvarez on 12/20/24.

import Foundation
import TabularData

extension TCMG {
    enum UtilityError: Error {
        case fileWrongType
    }

    static func newCSVFileURL(_ CSVFilePath: String) throws -> URL {
        let fileURL = URL(fileURLWithPath: CSVFilePath)
        guard fileURL.pathExtension == "csv" else {
            throw UtilityError.fileWrongType
        }
        return fileURL
    }
    
    static func createCSVDataFrame(_ csvfile: String) throws -> DataFrame {
        let csvOptions = CSVReadingOptions(
            hasHeaderRow: true,
            delimiter: ","
        )
        
        var newDataFrame: DataFrame = DataFrame()
        
        do {
            newDataFrame = try DataFrame(
                contentsOfCSVFile: newCSVFileURL(csvfile),
                options: csvOptions
            )
        } catch UtilityError.fileWrongType {
            print("ERROR: NOT A VALID CSV FILE")
        } catch {
            print("ERROR: AN UNKNOWN ERROR")
        }
        
        return newDataFrame
    }
}

/*
 
 Create a file not found error handler. MarsHabitats.csv
 was written as MarsHabitat.csv and it triggered an
 unknown error in the summary command.
 
 */
