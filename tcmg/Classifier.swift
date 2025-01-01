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
        
    }
}
