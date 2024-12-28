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
         do {
             let trainingData = try newCSVDataFrame(trainingDataFileName)
             print(trainingData)
         } catch UtilityError.fileWrongType {
             print("ERROR: NOT A VALID CSV FILE")
         } catch {
             print("ERROR: UNKNOWN ERROR")
         }
        
    }
}
