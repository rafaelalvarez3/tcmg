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
    
    static let configuration = CommandConfiguration(abstract:  "A utility to create and train Core ML models.")
    
    @Option(help: "The file path of the training data file.")
    var trainingDataFileName: String
    
    @Option(help: "The file path of the testing data file.")
    var testingDataFileName: String
    
    public func run() throws {
        let trainingFileURL = URL(fileURLWithPath: self.trainingDataFileName)
        let testingFileURL = URL(fileURLWithPath: self.testingDataFileName)
        
        print(trainingFileURL)
        print(testingFileURL)
    
    }
}
