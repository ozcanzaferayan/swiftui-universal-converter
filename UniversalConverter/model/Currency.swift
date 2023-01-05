//
//  Currency.swift
//  UniversalConverter
//
//  Created by Zafer AYAN on 2.01.2023.
//

import Foundation

class Currency: ObservableObject {
    @Published var name: String
    @Published var value: Double

    init(_ name: String, _ value: Double) {
        self.name = name
        self.value = value
    }
}
