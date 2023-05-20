//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error:Error)
    func didUpdateTheCurrency(coin:Double)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "A4D19344-071C-4CFB-850B-3F8BAFE3B160"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate : CoinManagerDelegate?
   
    
    func getCoinPrice(for currency:String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { Data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = Data{
                    let bitcoinPrice = self.parseJson(safeData)
                    self.delegate?.didUpdateTheCurrency( coin: bitcoinPrice!)
                }
                
            }
            task.resume()
        }
        
    }
    
    func parseJson(_ data:Data) -> Double? {
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
