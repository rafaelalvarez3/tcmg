//
//  Regressor.swift
//  tcmg
//
//  Created by Rafael Alvarez on 1/1/25.
//

import Foundation
import ArgumentParser
import TabularData
import CreateML

extension TCMG {
    
    
    /*
    struct OldRegressor: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "This is the regressor command.",
            discussion: "A longer description of this command that is shown in the help menu."
        )
        
        @OptionGroup var options: GlobalOptions
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
                .customLong("evaluate"),
                .customShort("e")
            ],
            help: "To evaluate the model after it is trained."
        )
        var evaluateRegressor: Bool = false
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
    */
}
