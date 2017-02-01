import Foundation
import Alamofire
import SVProgressHUD

public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [[String : Any]]

public typealias FailureHandler = ((JSONDictionary) -> Void)?
public typealias CompletionHandler = ((JSONArray) -> Void)?

class WeatherListAPI {
    
    init() {
        
    }
    
    var failureHandler: FailureHandler
    var completionHandler: CompletionHandler
    
    func request() {
        let urlString = "http://api.openweathermap.org/data/2.5/group"
        
        var params: JSONDictionary = [:]
        params["id"] = "4163971,2147714,2174003"
        params["units"] = "metric"
        params["appid"] = "dc04adf9c0460593c347f4db3ce7cd3c"
        
        let manager = NetworkManager.sharedInstance.manager!
        manager.request(urlString, method: .get, parameters: params).responseJSON { response in
            print("REQUEST: \(response.request!)")
            
            if let json  = response.result.value as? JSONDictionary {
                print("JSON: \(json)")
                
                if let msg = json["message"] as? String {
                    self.failureHandler?(json)
                    
                    SVProgressHUD.showError(withStatus: msg)
                } else {
                    self.completionHandler?(json["list"] as! JSONArray)
                }
            } else {
                self.failureHandler?([:])
                SVProgressHUD.showError(withStatus: response.result.error?.localizedDescription)
            }
        }
    }
}
