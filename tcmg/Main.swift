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
        abstract:  "A utility to create and train Core ML models.",
        subcommands: [Summary.self],
        defaultSubcommand: Summary.self
    )

    @Option(
        name: [
            .customLong("datafile"),
            .customShort("d")
        ],
        help: "The name of the data file."
    )
    var dataFileName: String
    
    @Option(
        name: [
            .customLong("regressor"),
            .customShort("r")
        ],
        help: "The name of the regressor model."
    )
    var regressorModelName: String
    
    @Option(
        name: [
            .customLong("classifier"),
            .customShort("c")
        ],
        help: "The name of the classifier model."
    )
    var classfierModelName: String

    public func run() throws {
        let csvOptions = CSVReadingOptions(
            hasHeaderRow: true,
            delimiter: ","
        )
        
        let formattingOptions = FormattingOptions(
            maximumLineWidth: 250,
            maximumCellWidth: 250,
            maximumRowCount: 15,
            includesColumnTypes: true
        )
        
        var primaryDataFrame: DataFrame = DataFrame()
        
        /* ----------------------------------------------------------------------- */
        
        do {
            primaryDataFrame = try DataFrame(
                contentsOfCSVFile: newCSVFileURL(dataFileName),
                options: csvOptions
            )
        } catch UtilityError.fileWrongType {
            print("ERROR: NOT A VALID CSV FILE")
        } catch {
            print("ERROR: AN UNKNOWN ERROR")
        }
        
        print(primaryDataFrame.description(options: formattingOptions))
        
        /* Create the regressor dataframe. */
        
        let regressorDataFrame = primaryDataFrame[["price", "solarPanels", "greenhouses", "size"]]
        
        /* Create the classifier dataframe. */
        
        let classifierDataFrame = primaryDataFrame[["purpose", "solarPanels", "greenhouses", "size"]]
        
        /* Divide the Regressor Data for Training and Evaluation */
        
        let (regEvalDataFrame, regTrainDataFrame) = regressorDataFrame.randomSplit(by: 0.20, seed: 5)
        
        /* Divide the Classifier Data for Training and Evaluation */
        
        let (classEvalDataFrame, classTrainDataFrame) = classifierDataFrame.randomSplit(by: 0.20, seed: 5)
        
        /* ----------------------------------------------------------------------- */
        
        /* Train the Regressor */
        
        let regressor = try MLLinearRegressor(
            trainingData: DataFrame(regTrainDataFrame),
            targetColumn: "price"
        )
        
        print(regressor)
        
        /* Evaluate the Regressor */
        
        let worstTrainingError = regressor.trainingMetrics.maximumError
        let worstValidationError = regressor.validationMetrics.maximumError
        
        print(worstTrainingError)
        print(worstValidationError)
        
        let regressorEvaluation = regressor.evaluation(on: DataFrame(regEvalDataFrame))
        let worstEvaluationError = regressorEvaluation.maximumError
        
        print(regressorEvaluation)
        print(worstEvaluationError)
        
        /* Train the Classifier */
        
        let classifier = try MLClassifier(
            trainingData: DataFrame(classTrainDataFrame),
            targetColumn: "purpose"
        )
        
        print(classifier)
        
        /* Evaluate the Classifier */
        
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
        
        /* Save the Model */
        
        let regressorMetadata = MLModelMetadata(
            author: "Rafael Alvarez",
            shortDescription: "Predicts the price of a habitat on Mars.",
            version: "1.0"
        )
        
        print(regressorMetadata)
        
        try regressor.write(to: URL(fileURLWithPath: "\(regressorModelName).mlmodel"), metadata: regressorMetadata)
        
        
        let classifierMetadata = MLModelMetadata(
            author: "Rafael Alvarez",
            shortDescription: "Predicts the price of a habitat on Mars.",
            version: "1.0"
        )
        
        print(classifierMetadata)
        
        try classifier.write(to: URL(fileURLWithPath: "\(classfierModelName).mlmodel"), metadata: classifierMetadata)
        
    }
}
