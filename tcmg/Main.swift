//  Main.swift
//  tcmg
//  Created by Rafael Alvarez on 12/16/24.
//

import Foundation
import ArgumentParser

@main
struct TCMG: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract:  "A utility to create and train Core ML models.",
        discussion: "A longer description of this command that is shown in the help menu.",
        version: "0.0.1",
        subcommands: [
            Info.self,
            Train.self
        ]
    )
}
