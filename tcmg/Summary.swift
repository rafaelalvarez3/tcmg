//  Summary.swift
//  tcmg
//  Created by Rafael Alvarez on 12/31/24.

import Foundation
import ArgumentParser
import TabularData

extension TCMG {
    struct Summary: ParsableCommand {
        
        static let configuration = CommandConfiguration(
            abstract: "Prints out a summary of the loaded data frame.",
            discussion: "A longer description of this command that is shown in the help menu."
        )
        
        @OptionGroup var options: GlobalOptions
        @Flag var columnNames: Bool = false
        
        public func run() throws {
            
            let csvOptions = CSVReadingOptions(
                hasHeaderRow: true,
                delimiter: ","
            )
            
            var summaryDataFrame: DataFrame = DataFrame()
            
            do {
                summaryDataFrame = try DataFrame(
                    contentsOfCSVFile: newCSVFileURL(options.dataFileName),
                    options: csvOptions
                )
            } catch UtilityError.fileWrongType {
                print("ERROR: NOT A VALID CSV FILE")
            } catch {
                print("ERROR: AN UNKNOWN ERROR")
            }
            
            print(columnNames ? summaryDataFrame.columns.map { colName in colName.name } : summaryDataFrame.summary())
            
            //print(summaryDataFrame.summary())
            //print(summaryDataFrame.columns.map { colName in colName.name })
        }
    }
}
