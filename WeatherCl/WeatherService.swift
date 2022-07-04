//
//  WeatherService.swift
//  WeatherCl
//
//  Created by KARAN  on 09/02/22.
//
import CoreLocation
import Foundation

public final class WeatherService : NSObject{
    private let locationManager = CLLocationManager()
    private let API_KEY = "446676f70c6061ce029d85196c8ec3a9"
    private var completionHandler : ((Weather) ->Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    public func loadWeatherData(_ completionHandler : @escaping((Weather) ->Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forcordinates coordinates: CLLocationCoordinate2D){
        
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        guard let url = URL(string: urlString)else{return}
        
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            guard error == nil, let data = data else{return}
            if let response = try? JSONDecoder().decode(ApiResponse.self, from: data){
                self.completionHandler?(Weather(response: response))
            }
            
        }.resume()

    
}
}
extension WeatherService : CLLocationManagerDelegate{
    public func locationManager(_ manager: CLLocationManager,didUpdateLocations locations :[CLLocation]) {
        
        guard let location = locations.first else {return}
        makeDataRequest(forcordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error : Error){
        print("Something Went Worng : \(error.localizedDescription)")
    }
}
struct ApiResponse :Decodable{
    let name : String
    let main : ApiMain
    let weather : [ApiWeather]
}
struct ApiMain : Decodable {
    let temp : Double
}
struct ApiWeather: Decodable {
    let description : String
    let iconname : String
    
    
    enum CodingKeys : String, CodingKey {
        case description
        case iconname = "main"
    }
    
}
