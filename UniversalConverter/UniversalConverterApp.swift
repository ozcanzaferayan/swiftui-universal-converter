//
//  UniversalConverterApp.swift
//  UniversalConverter
//
//  Created by Zafer AYAN on 1.01.2023.
//

import SwiftUI

@main
struct UniversalConverterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(currencies: Currencies())
        }
    }
}
