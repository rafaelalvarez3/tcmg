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
    }
}
