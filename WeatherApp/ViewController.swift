//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mithilesh Singh on 27/02/24.
//

import UIKit

class ViewController : UIViewController, WeatherManagerDelegate {
    
    @IBOutlet weak var btnSearchByLocation: UIButton!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var imageCloud: UIImageView!
    
    let weatherManager =  WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
    }
    
    
    @IBAction func currentLocationClicked(_ sender: UIButton) {

    }
    
    @IBAction func searchByLocationNameClicked(_ sender: UIButton) {
        if textFieldSearch?.text?.isEmpty == true {
            textFieldSearch.placeholder = "Type Something"
        }else{
            weatherManager.fetchWeatherByCityName(textFieldSearch?.text ?? "")
        }
    }
    
    
    // MARK: - WeatherManagerDelegate
    
    func populateWeatherData(_ weatherData: WeatherData) {
        labelTemperature.text = String(format: "%.1f", weatherData.main.temp)
        labelCityName.text = weatherData.name
        let iconName = getIcon(iconId: weatherData.weather[0].id)
        imageCloud.image = UIImage(systemName: iconName)
    }
    
    func getIcon(iconId: Int)-> String {
        switch iconId {
        case 200...232:do {
            return "cloud.bolt.fill"
        }
        case 600...622:do {
            return "snow"
        }
        default:do {
            return "cloud"
        }
        }
    }
}
