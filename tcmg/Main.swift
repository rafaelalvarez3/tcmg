//
//  main.swift
//  tcmg
//
//  Created by Rafael Alvarez on 12/16/24.
//

import Foundation
import ArgumentParser

@main
struct Main: ParsableCommand {
    static let configuration = CommandConfiguration(abstract:  "A utility to create and train Core ML models.")
    
    @Option(help: "A training data file.")
    var trainingDataFile: String
    
    @Option(help: "A testing data file.")
    var testingDataFile: String
    
    static func main() {
        print("hello tcmg")
    }
}
