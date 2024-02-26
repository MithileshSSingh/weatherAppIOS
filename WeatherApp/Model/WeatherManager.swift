//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mithilesh Singh on 27/02/24.
//

import Foundation



class WeatherManager{
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=8a99fa0fdb99ad69e6c1f916af517d19&units=metric"
    
    var delegate: WeatherManagerDelegate? = nil
    
    func fetchWeatherByCityName(_ cityName:String){
        if let url = URL(string: "\(baseUrl)&q=\(cityName)"){
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url,completionHandler: handle(data:response:error:))
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil{
            print(error ?? "error")
            return
        }
        
        if let safeData = data {
            do{
                print(String(decoding: safeData, as: UTF8.self))
                let weatherData:WeatherData = try JSONDecoder().decode(WeatherData.self, from: safeData)
                DispatchQueue.main.async {
                    self.delegate?.populateWeatherData(weatherData)
                }
            }catch{
                print("Error while parsing")
            }
        }
    }
}

// MARK: - Weather delegates

protocol WeatherManagerDelegate{
    func populateWeatherData(_ weatherData: WeatherData)
}

// MARK: - pojos

struct WeatherData : Codable{
    let coord: CoOrdinates
    let weather: [Weather]
    let name: String
    let main: Main
}

struct CoOrdinates  : Codable{
    let lat: Double
    let lon: Double
}

struct Weather : Codable{
    let id:Int
}

struct Main : Codable{
    let temp: Double
}
