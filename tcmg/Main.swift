//
//  Main.swift
//  tcmg
//
//  Created by Rafael Alvarez on 12/16/24.
//

import Foundation
import ArgumentParser
import CreateML
import TabularData


@main
struct Main: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract:  "A utility to create and train Core ML models."
    )
    
    @Option(
        name: [
            .customLong("trainfile"),
            .customShort("t")
        ],
        help: "The path of the training file."
    )
    var trainingDataFileName: String
    
    public func run() throws {
        
        var trainingData: DataFrame = DataFrame()
        
        do {
            trainingData = try newCSVDataFrame(trainingDataFileName)
            print("CSV loaded to DataFrame successfully!")
        } catch UtilityError.fileWrongType {
            print("ERROR: NOT A VALID CSV FILE")
        } catch {
            print("ERROR: UNKNOWN ERROR")
        }
        
        print(trainingData.summary())
        
    }
}
