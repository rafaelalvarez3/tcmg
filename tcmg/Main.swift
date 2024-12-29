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
            .customLong("datafile"),
            .customShort("d")
        ],
        help: "The path of the data file."
    )
    var dataFileName: String
    
    public func run() throws {
        let csvOptions = CSVReadingOptions(hasHeaderRow: true,
                                           delimiter: ",")
        
        let formattingOptions = FormattingOptions(maximumLineWidth: 250,
                                                  maximumCellWidth: 250,
                                                  maximumRowCount: 100,
                                                  includesColumnTypes: true)
        
        var primaryDataFrame: DataFrame = DataFrame()
        
        do {
            let dataFileURL = try newCSVFileURL(dataFileName)
            primaryDataFrame = try DataFrame(contentsOfCSVFile: dataFileURL,
                                             options: csvOptions)
        } catch UtilityError.fileWrongType {
            print("ERROR: NOT A VALID CSV FILE")
        } catch {
            print("ERROR: AN UNKNOWN ERROR")
        }

        print(primaryDataFrame.description(options: formattingOptions))
        
        /* Create the regressor dataframe. */
        
        let regressorColumns = ["price", "solarPanels", "greenhouses", "size"]
        let regressorDataFrame = primaryDataFrame[regressorColumns]
        
        print(regressorDataFrame.description(options: formattingOptions))
        
        /* Create the classifier dataframe. */
        
        let classifierColumns = ["purpose", "solarPanels", "greenhouses", "size"]
        let classifierDataFrame = primaryDataFrame[classifierColumns]
        
        print(classifierDataFrame.description(options: formattingOptions))
        
        /* Divide the Regressor Data for Training and Evaluation */
        
        let (regressorEvaluationDataFrame, regressorTrainingDataFrame) = regressorDataFrame.randomSplit(by: 0.20, seed: 5)
        
        print(regressorEvaluationDataFrame)
        print(regressorTrainingDataFrame)
        
        /* Divide the Classifier Data for Training and Evaluation */
        
        let (classifierEvaluationDataFrame, classifierTrainingDataFrame) = classifierDataFrame.randomSplit(by: 0.20, seed: 5)
        
        print(classifierEvaluationDataFrame)
        print(classifierTrainingDataFrame)
        
        /* ----------------------------------------------------------------------- */
        
    }
}
