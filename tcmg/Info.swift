//  Summary.swift
//  tcmg
//  Created by Rafael Alvarez on 12/31/24.

import Foundation
import ArgumentParser
import TabularData

extension TCMG {
    struct Info: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Prints out summary information about the loaded data frame.",
            discussion: "A longer description of this command that is shown in the help menu.",
            subcommands: [AllInfo.self, ColumnInfo.self],
            defaultSubcommand: AllInfo.self
        )
        
        /* --------------------------------------------------------------------- */
        
        struct AllInfo: ParsableCommand {
            static let configuration = CommandConfiguration(
                commandName: "all",
                abstract: "Prints out a full summary of the loaded data frame."
            )
            
            @OptionGroup var options: GlobalOptions
            
            public func run() throws {
                let summaryDataFrame = try createCSVDataFrame(options.dataFileName)
                print(summaryDataFrame.summary())
                print("The data frame is \(MemoryLayout.size(ofValue: summaryDataFrame)) bytes in size.")
            }
            
        }
        
        /* --------------------------------------------------------------------- */
        
        struct ColumnInfo: ParsableCommand {
            static let configuration = CommandConfiguration(
                commandName: "columns",
                abstract: "Prints out the columns of the loaded data frame."
            )
            
            @OptionGroup var options: GlobalOptions
            
            public func run() throws {
                let summaryDataFrame = try createCSVDataFrame(options.dataFileName)
                let columnNames = summaryDataFrame.columns.map { $0.name }
                
                print("--------------------------")
                
                for columnName in columnNames {
                    print(columnName)
                }
                
                print("--------------------------")
                
                print("Total Columns: \(columnNames.count)")
                
                print("--------------------------")
            }
        }
        
        /* --------------------------------------------------------------------- */
    }
}


