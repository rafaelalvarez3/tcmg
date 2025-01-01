//
//  Classifier.swift
//  tcmg
//
//  Created by Rafael Alvarez on 1/1/25.
//

import Foundation
import ArgumentParser
import TabularData
import CreateML

extension TCMG {
    struct Classifier: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "This is the classfier command.",
            discussion: "A longer description of this command that is shown in the help menu."
        )
        
        @OptionGroup var options: GlobalOptions
        @Option(
            name: [
                .customLong("class-name"),
                .customShort("c")
            ],
            help: "The name of the classfier model."
        )
        var classfierModelName: String
        @Flag(
            name: [
                .customLong("evaluate"),
                .customShort("e")
            ],
            help: "To evaluate the model after it is trained."
        )
        var evaluateClassifier: Bool = false
        @Flag(
            name: [
                .customLong("save"),
                .customShort("s")
            ],
            help: "To save the model after it is trained."
        )
        var saveModel: Bool = false
        
        public func run() throws {
            let primaryDataFrame = try createCSVDataFrame(options.dataFileName)
            
            /* Create the classifier dataframe. */
            
            let classifierDataFrame = primaryDataFrame[["purpose", "solarPanels", "greenhouses", "size"]]
        
            
            /* Divide the Classifier Data for Training and Evaluation */
            
            let (classEvalDataFrame, classTrainDataFrame) = classifierDataFrame.randomSplit(by: 0.20, seed: 5)

            /* Train the Classifier */
            
            let classifier = try MLClassifier(
                trainingData: DataFrame(classTrainDataFrame),
                targetColumn: "purpose"
            )
            
            print(classifier)
            
        }
        
    }
}
