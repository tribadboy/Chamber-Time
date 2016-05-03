//
//  FindingViewController.swift
//  Chamber Time
//
//  Created by YangYueyang on 16/5/3.
//  Copyright © 2016年 NJU. All rights reserved.
//

import UIKit
import CoreLocation

class FindingViewController: UIViewController, CLLocationManagerDelegate {
    
    let ChickenSoup : [String] = ["All of life is an act of letting go,but what hurts the most is not taking a moment to say goodbye.",
                                         "Even if you get no applause, you should accept a curtain call gracefully and appreciate your own efforts.",
                                         "Never frown, even when you are sad, because you never know who is falling in love with your smile.",
                                         "Just because someone doesn‘t love you the way you want them to, doesn‘t mean they don‘t love you with all they have.",
                                         "Maybe God wants us to meet a few wrong people before meeting the right one, so that when we finally meet the person, we will know how to be grateful.",
                                         "An ideal day should begin with a cute little yawn on your face, A cup of coffee in your hand A sms from me on your mobile! Good Morning."
    ]
    
    let locationManager : CLLocationManager = CLLocationManager()

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherPic: UIImageView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let background = UIImage(named: "background")
        self.view.backgroundColor = UIColor(patternImage:background!)
        
        self.loadingIndicator.startAnimating()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        if locationManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()
        
        srand(UInt32(time(nil)))
        let random:Int = Int(rand())
        let num:Int = ChickenSoup.count
        content.text = ChickenSoup[random % num]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations[locations.count-1]
        if(location.horizontalAccuracy > 0) {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            updateWeatherInfo(location.coordinate.latitude,longitude:location.coordinate.longitude)
            locationManager.stopUpdatingLocation()
        }
   
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        self.location.text = "无法获取位置信息"
        self.temperature.text = nil
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.hidden = true
    }
    
    func updateWeatherInfo(latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let weatherUrl = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=1ebebe0dfbf0c6b9b5de5db2b7d9f633"
        print(weatherUrl)
        let url = NSURL(string:weatherUrl)
        /*
        let urlSession : NSURLSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithURL(url!){
            (data, response, error) -> Void in
            if error != nil {
                print("url error, \(error)\n")
                return
            } else {
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode : NSInteger = httpResponse.statusCode
                print("status code \(statusCode)\n")
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options:
                    NSJSONReadingOptions.AllowFragments) as! NSDictionary
                print(json.description)
                self.updateJsonData(json)
            }
        }
        
        task.resume()
        */
        let request:NSURLRequest = NSURLRequest(URL:url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
            if error != nil {
                print("url error, \(error)\n")
                self.location.text = "天气信息暂时无法使用"
                self.temperature.text = nil
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.hidden = true
                return
            } else {
                let httpResponse = response as! NSHTTPURLResponse
                let statusCode : NSInteger = httpResponse.statusCode
                print("status code \(statusCode)\n")
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options:
                    NSJSONReadingOptions.AllowFragments) as! NSDictionary
                print(json.description)
                self.updateJsonData(json)
            }        }
    }
    
    func updateJsonData(jsonResult: NSDictionary!) {
        var tempResult:Int
        if let temp = jsonResult["main"]?["temp"] as? Double {
            tempResult = Int(temp - 273.15)
            self.temperature.text = "\(tempResult)摄氏度"
        } else {
            self.location.text = "天气信息暂时无法使用"
            self.temperature.text = nil
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.hidden = true
            return
        }
        if let city = jsonResult["name"] as? String {
            self.location.text = city
        }
        
        let condition = (jsonResult["weather"] as? NSArray)![0]["id"] as! Int
        switch condition {
        case 0...299:   self.weatherPic.image = UIImage(named: "weather-forecast-12")
        case 300...499: self.weatherPic.image = UIImage(named: "weather-forecast-16")
        case 500...599: self.weatherPic.image = UIImage(named: "weather-forecast-5")
        case 600...699: self.weatherPic.image = UIImage(named: "weather-forecast-6")
        case 700...799: self.weatherPic.image = UIImage(named: "weather-forecast-7")
        case 800: self.weatherPic.image = UIImage(named: "weather-forecast-8")
        case 801: self.weatherPic.image = UIImage(named: "weather-forecast-10")
        case 802...803: self.weatherPic.image = UIImage(named: "weather-forecast-1")
        case 804: self.weatherPic.image = UIImage(named: "weather-forecast-4")
        default:    self.weatherPic.image = nil
        }
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.hidden = true
    }
 
}
