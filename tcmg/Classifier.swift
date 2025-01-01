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
        var classifierModelName: String
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
            
            if evaluateClassifier {
                let trainingError = classifier.trainingMetrics.classificationError
                let trainingAccuracy = (1.0 - trainingError) * 100
                
                print(trainingError)
                print(trainingAccuracy)
                
                let validationError = classifier.validationMetrics.classificationError
                let validationAccuracy = (1.0 - validationError) * 100
                
                print(validationError)
                print(validationAccuracy)
                
                let classifierEvaluation = classifier.evaluation(on: DataFrame(classEvalDataFrame))
                
                print(classifierEvaluation)
                
                let evaluationError = classifierEvaluation.classificationError
                let evaluationAccuracy = (1.0 - evaluationError) * 100
                
                print(evaluationError)
                print(evaluationAccuracy)
            }
            
            if saveModel {
                let classifierMetadata = MLModelMetadata(
                    author: "Rafael Alvarez",
                    shortDescription: "Predicts the price of a habitat on Mars.",
                    version: "1.0"
                )
                
                try classifier.write(to: URL(
                                            fileURLWithPath: "\(classifierModelName).mlmodel"),
                                            metadata: classifierMetadata
                                        )
                
                print("SUCCESS: \(classifierModelName).mlmodel saved!")
                
            }
            
        }
        
    }
}
