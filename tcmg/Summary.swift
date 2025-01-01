//  Summary.swift
//  tcmg
//  Created by Rafael Alvarez on 12/31/24.

import Foundation
import ArgumentParser
import TabularData

extension TCMG {
    struct Summary: ParsableCommand {
        
        @OptionGroup var options: GlobalOptions
        
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
            
            print(summaryDataFrame.summary())
        }
    }
}
