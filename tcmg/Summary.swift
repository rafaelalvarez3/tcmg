//
//  Summary.swift
//  tcmg
//
//  Created by Rafael Alvarez on 12/30/24.
//

import Foundation
import ArgumentParser
import TabularData

extension Main {
    struct Summary: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Prints a summary of the loaded DataFrame."
        )

    }
}
