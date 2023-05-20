//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    
    
    var coinManager = CoinManager()
    
    

    @IBOutlet var bitcoinLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self 
    }


}


extension ViewController : CoinManagerDelegate {
    func didUpdateTheCurrency(coin: Double) {
        DispatchQueue.main.async {
            
            self.bitcoinLabel.text = String(format: "%0.1f", coin)
        }
        
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


extension ViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension ViewController : UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(coinManager.currencyArray[row])
        currencyLabel.text = coinManager.currencyArray[row]
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for:selectedCurrency)
        
    }
}

