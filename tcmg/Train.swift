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
                print("regressor command works!")
            }
        }
        
        /* --------------------------------------------------------------------- */
        
        struct Classifier: ParsableCommand {
            static let configuration = CommandConfiguration(
                abstract: "Trains the classifier.",
                discussion: "A longer description of this command that is shown in the help menu."
            )
            
            public func run() throws {
                print("classifier command works!")
            }
        }
        
        /* --------------------------------------------------------------------- */
        
    }
}
