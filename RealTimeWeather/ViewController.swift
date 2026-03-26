//
//  ViewController.swift
//  RealTimeWeather
//
//  Created by Viktoriia Savchuk  on 26/03/2026.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        
    }
    
}

