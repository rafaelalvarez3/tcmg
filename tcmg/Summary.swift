//  Summary.swift
//  tcmg
//  Created by Rafael Alvarez on 12/31/24.

import Foundation
import ArgumentParser
import TabularData

extension TCMG {
    struct Summary: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Prints out summary information about the loaded data frame.",
            discussion: "A longer description of this command that is shown in the help menu.",
            subcommands: [All.self, ColumnInfo.self],
            defaultSubcommand: All.self
        )
        
        /* --------------------------------------------------------------------- */
        
        struct All: ParsableCommand {
            static let configuration = CommandConfiguration(
                abstract: "Prints out a full summary of the loaded data frame."
            )
            
            @OptionGroup var options: GlobalOptions
            
            public func run() throws {
                let summaryDataFrame = try createCSVDataFrame(options.dataFileName)
                print(summaryDataFrame.summary())
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
                print(
                    summaryDataFrame.columns.map { colName in
                        colName.name
                    }
                )
            }
        }
        
        /* --------------------------------------------------------------------- */
    }
}


