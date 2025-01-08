//
//  Options.swift
//  tcmg
//
//  Created by Rafael Alvarez on 1/7/25.
//

import Foundation
import ArgumentParser

/* --------------------------------------------------------------------- */
struct GlobalOptions: ParsableArguments {
    @Option(
        name: [
            .customLong("datafile"),
            .customShort("d")
        ],
        help: "The name of the data file."
    )
    var dataFileName: String
}
/* --------------------------------------------------------------------- */
struct TrainingOptions: ParsableArguments {
    @Flag(
        name: [
            .customLong("evaluate"),
            .customShort("e")
        ],
        help: "To evaluate the model after it is trained."
    )
    var evaluate: Bool = false
    @Option(
        name: [
            .customLong("name"),
            .customShort("n")
        ],
        help: "The name of the model."
    )
    var modelName: String
    @Flag(
        name: [
            .customLong("save"),
            .customShort("s")
        ],
        help: "To save the model after it is trained."
    )
    var saveModel: Bool = false
}
/* --------------------------------------------------------------------- */
