//
//  Options.swift
//  tcmg
//
//  Created by Rafael Alvarez on 1/7/25.
//

import Foundation
import ArgumentParser

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
