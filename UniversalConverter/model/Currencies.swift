//
//  Currencies.swift
//  UniversalConverter
//
//  Created by Zafer AYAN on 2.01.2023.
//

import Foundation
import SwiftSoup
import Alamofire

class Currencies: ObservableObject {
    @Published var currencies: [Currency] = []
    @Published var gold: Currency? = nil
    @Published var usd: Currency? = nil
    @Published var eur: Currency? = nil
    @Published var gbp: Currency? = nil
    
     init() {
        AF.request("https://www.doviz.com").responseString { response in
            print(":")
            do {
                
                
                let doc = try SwiftSoup.parse(response.value!)
                self.currencies = try self.convertCurrencies(doc)
                self.gold = self.currencies[0]
                self.usd = self.currencies[1]
                self.eur = self.currencies[2]
                self.gbp = self.currencies[3]
            } catch {
                print(error)
            }
        }
    }
    
    func convertCurrencies(_ doc: Document) throws -> [Currency] {
        do {
            let currencyTypes = ["gram-altin", "USD", "EUR", "GBP"]
            
            for currency in currencyTypes {
                let text = try doc.select("span[data-socket-key=\(currency)]").first()?.text()
                    .replacingOccurrences(of: ".", with: "")
                    .replacingOccurrences(of: ",", with: ".")
                
                currencies.append(Currency(currency, Double(text!)!))
            }
            return  currencies
        } catch {
            throw error
        }
    }
}
