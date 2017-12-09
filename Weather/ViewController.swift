//
//  ViewController.swift
//  Weather
//
//  Created by Charlie Cuddy on 12/6/17.
//  Copyright © 2017 Charlie Cuddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityEnteredText: UITextField!
    
    @IBOutlet weak var cityWeatherLabel: UILabel!
    
    @IBAction func getWeather(_ sender: Any) {
        
        print("get weather")
        
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + cityEnteredText.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                var message = ""
                
                if let error = error {
                    print(error)
                    
                } else {
                    if let unwrappedData = data {
                        
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            
                            if contentArray.count > 1 {
                                stringSeparator = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                
                                if newContentArray.count > 1 {
                                    
                                    message = "Current " + self.cityEnteredText.text! + " weather: " + newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                    
                                }
                            }
                        }
                    }
                }
                
                if message == "" {
                    
                    message = "The weather for " + self.cityEnteredText.text! + " couldn't be found. Please try one more time."
                    
                }
                
                DispatchQueue.main.sync(execute: {
                    self.cityWeatherLabel.text = message
                })
            }
            
            task.resume()
            
        } else {
            
            cityWeatherLabel.text = "The weather couldn't be found. Please try again."
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

