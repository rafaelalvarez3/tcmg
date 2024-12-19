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
    
    @Option(name: [.customLong("trainfile"), .customShort("r")], help: "The file path of the training data file.")
    var trainingDataFileName: String
    
    @Option(name: [.customLong("testfile"), .customShort("e")], help: "The file path of the testing data file.")
    var testingDataFileName: String
    
    public func run() throws {
        let trainingFileURL = URL(fileURLWithPath: self.trainingDataFileName)
        let testingFileURL = URL(fileURLWithPath: self.testingDataFileName)
        
        do {
            let trainingData = try DataFrame(contentsOfJSONFile: trainingFileURL)
            print("Training data loaded.")
        } catch {
            print("TRAINING: AN UNKNOWN ERROR OCCURRED")
        }
        
        do {
            let testingData = try DataFrame(contentsOfJSONFile: testingFileURL)
            print("Testing data loaded.")
        } catch {
            print("TESTING: AN UNKNOWN ERROR OCCURRED")
        }
    }
}
