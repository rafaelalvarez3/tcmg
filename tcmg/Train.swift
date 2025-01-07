//
//  Train.swift
//  tcmg
//
//  Created by Rafael Alvarez on 1/5/25.
//

import Foundation
import ArgumentParser
import TabularData
import CreateML

extension TCMG {
    struct Train: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Trains the models.",
            discussion: "A longer description of this command that is shown in the help menu.",
            subcommands: [Regressor.self, Classifier.self]
        )
        
        /* --------------------------------------------------------------------- */
        
        struct Regressor: ParsableCommand {
            static let configuration = CommandConfiguration(
                abstract: "Trains the regressor.",
                discussion: "A longer description of this command that is shown in the help menu."
            )
            
            @OptionGroup var options: GlobalOptions
            @Flag(
                name: [
                    .customLong("evaluate"),
                    .customShort("e")
                ],
                help: "To evaluate the model after it is trained."
            )
            var evaluateRegressor: Bool = false
            @Option(
                name: [
                    .customLong("reg-name"),
                    .customShort("r")
                ],
                help: "The name of the regressor model."
            )
            var regressorModelName: String
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
                
                /* Create the regressor dataframe. */
                
                let regressorDataFrame = primaryDataFrame[["price", "solarPanels", "greenhouses", "size"]]
                
                /* Divide the Regressor Data for Training and Evaluation */
                
                let (regEvalDataFrame, regTrainDataFrame) = regressorDataFrame.randomSplit(by: 0.20, seed: 5)
                
                let regressor = try MLLinearRegressor(
                    trainingData: DataFrame(regTrainDataFrame),
                    targetColumn: "price"
                )
                
                print(regressor)
                
                print("------------------------------------------------")
                
                if evaluateRegressor {
                    /* Evaluate the Regressor */
                    
                    let worstTrainingError = regressor.trainingMetrics.maximumError
                    let worstValidationError = regressor.validationMetrics.maximumError
                    
                    print(worstTrainingError)
                    print(worstValidationError)
                    
                    let regressorEvaluation = regressor.evaluation(on: DataFrame(regEvalDataFrame))
                    let worstEvaluationError = regressorEvaluation.maximumError
                    
                    print(regressorEvaluation)
                    print(worstEvaluationError)
                    
                }
                
                if saveModel {
                    let regressorMetadata = MLModelMetadata(
                        author: "Rafael Alvarez",
                        shortDescription: "Predicts the price of a habitat on Mars.",
                        version: "1.0"
                    )
                    
                    try regressor.write(to: URL(
                                                fileURLWithPath: "\(regressorModelName).mlmodel"),
                                                metadata: regressorMetadata
                                            )
                    
                    print("SUCCESS: \(regressorModelName).mlmodel saved!")
                    
                }
            }
        }
        

        
        /* --------------------------------------------------------------------- */
        
        
        
        
        
        struct Classifier: ParsableCommand {
            static let configuration = CommandConfiguration(
                abstract: "Trains the classifier.",
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
        
        /* --------------------------------------------------------------------- */
        
    }
}
