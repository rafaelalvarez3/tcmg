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
            let summaryDataFrame = try createCSVDataFrame(options.dataFileName)
             
            /* print(columnNames ? summaryDataFrame.columns.map { colName in
                colName.name
            } : summaryDataFrame.summary()) */
            
            if columnNames {
                print(
                    summaryDataFrame.columns.map { colName in
                        colName.name
                    }
                )
            } else {
                print(summaryDataFrame.summary())
            }
        }
    }
}
