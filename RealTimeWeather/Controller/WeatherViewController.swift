//
//  ViewController.swift
//  RealTimeWeather
//
//  Created by Viktoriia Savchuk  on 26/03/2026.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var backgroudImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var lan: CLLocationDegrees?
    var lon: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    //hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Please enter a city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
}

//MARK: - WeatherManagerDelegate


extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            print(weather.cityName)
            self.weatherDescriptionLabel.text = weather.weatherDescription
            self.backgroudImageView.image = UIImage(named: weather.conditionBackground)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

protocol LocationManagerDelegate {
    func didUpdateLocation(_ locationManager: CLLocationManager, location: CLLocation)
    func didFailWithError(error: Error)
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lan = location.coordinate.latitude
            lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lan!, longitude: lon!)
        }
    }
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        
        weatherManager.fetchWeather(latitude: lan!, longitude: lon!)
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

