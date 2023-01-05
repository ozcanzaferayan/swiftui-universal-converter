//
//  ContentView.swift
//  UniversalConverter
//
//  Created by Zafer AYAN on 1.01.2023.
//

import SwiftUI
import SwiftSoup
import Alamofire

struct ContentView: View {
    @State var inputValue: String = ""
    @State var convertedValue: String = " "
    
    @ObservedObject var currencies: Currencies
    
    var body: some View {
        VStack {
            TextField("Enter value. Eg: 100kg", text: $inputValue)
                .textFieldStyle(.roundedBorder)
                .onChange(of: inputValue, perform: handleEditingChanged)
            Text(verbatim: convertedValue)
        }
        .padding()
    }

    func hasNumbers(_ text: String) -> Bool {
        let numbers = CharacterSet.decimalDigits
        return text.rangeOfCharacter(from: numbers) != nil
    }
    
    
    func handleEditingChanged(text: String) -> Void {
        if(!hasNumbers(text)) {
            self.convertedValue = " "
            return
        }
        let textWithoutSpaces = text.replacingOccurrences(of: " ", with: "")
        let suffix = textWithoutSpaces.replacingOccurrences(of: " ", with: "").components(separatedBy: CharacterSet.decimalDigits).joined()
        let suffixes = ["kg", "lbs", "mi", "m", "ft", "c", "f", "km", "gal", "l", "lt", "$", "dollar", "usd", "€", "euro", "eur", "gold", "ons" ]
        let contains = suffixes.contains(suffix)
        if(contains) {
            self.convertedValue = convertInput(textWithoutSpaces)
        } else {
            self.convertedValue = " "
        }
        
    }
    
    func convertInput(_ text: String) -> String {
        if(text.contains("kg")) {
            let value = text.replacingOccurrences(of: "kg", with: "")
            let convertedValue = Double(value)! * 2.20462
            return "\(convertedValue) lbs"
        } else if(text.contains("lbs")) {
            let value = text.replacingOccurrences(of: "lbs", with: "")
            let convertedValue = Double(value)! / 2.20462
            return "\(convertedValue) kg"
        }
        else if(text.contains("mi")) {
            let value = text.replacingOccurrences(of: "mi", with: "")
            let convertedValue = Double(value)! / 0.621371
            return "\(convertedValue) km"
        } else if (text.contains("ft")) {
            let value = text.replacingOccurrences(of: "ft", with: "")
            let convertedValue = Double(value)! / 3.28084
            return "\(convertedValue) m"
        } else if (text.contains("c")) {
            let value = text.replacingOccurrences(of: "c", with: "")
            let convertedValue = Double(value)! * 1.8 + 32
            return "\(convertedValue) f"
        } else if (text.contains("f")) {
            let value = text.replacingOccurrences(of: "f", with: "")
            let convertedValue = (Double(value)! - 32) / 1.8
            return "\(convertedValue) c"
        } else if(text.contains("km")) {
            let value = text.replacingOccurrences(of: "km", with: "")
            let convertedValue = Double(value)! * 0.621371
            return "\(convertedValue) mi"
        } else if(text.contains("$") || text.contains("dollar") ||  text.contains("usd")) {
            let value = text.replacingOccurrences(of: "$", with: "")
                .replacingOccurrences(of: "dollar", with: "")
                .replacingOccurrences(of: "usd", with: "")
            print(value)
            let convertedValue = Double(value)! * currencies.usd!.value
            return "\(convertedValue) TL"
        } else if(text.contains("€") || text.contains("euro") || text.contains("eur")) {
            let value = text.replacingOccurrences(of: "€", with: "")
                .replacingOccurrences(of: "euro", with: "")
                .replacingOccurrences(of: "eur", with: "")
            let convertedValue = Double(value)! * currencies.eur!.value
            return "\(convertedValue) TL"
        }else if(text.contains("gold") || text.contains("altın")) {
            let value = text.replacingOccurrences(of: "gold", with: "")
                .replacingOccurrences(of: "altın", with: "")
            let convertedValue = Double(value)! * currencies.gold!.value
            return "\(convertedValue) TL"
        }else if(text.contains("ons")) {
            let value = text.replacingOccurrences(of: "ons", with: "")
            let convertedValue = Double(value)! * currencies.gold!.value * 31.1
            return "\(convertedValue) TL"
        }
        
        else if(text.contains("gal")) {
            let value = text.replacingOccurrences(of: "gal", with: "")
            let convertedValue = Double(value)! / 0.264172
            return "\(convertedValue) lt"
        }
        else if( text.contains("l") || text.contains("lt") ) {
            let value = text.replacingOccurrences(of: "lt", with: "")
                .replacingOccurrences(of: "l", with: "")
            let convertedValue = Double(value)! * 0.264172
            return "\(convertedValue) gal"
        }
        else if (text.contains("m")) {
            let value = text.replacingOccurrences(of: "m", with: "")
            let convertedValue = Double(value)! * 3.28084
            return "\(convertedValue) ft"
        }
        else {
            return " "
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( currencies: Currencies())
    }
}
