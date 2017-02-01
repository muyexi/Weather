import Foundation
import ObjectMapper

class Weather: Mappable {

    var id: Int!
    var name: String!
    
    var temp: Int!
    var tempMin: Int!
    var tempMax: Int!
    
    var main: String!
    var icon: String!
    var description: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        
        temp        <- map["main.temp"]
        tempMin     <- map["main.temp_min"]
        tempMax     <- map["main.temp_max"]
        
        main        <- map["weather.0.main"]
        icon        <- map["weather.0.icon"]
        description <- map["weather.0.description"]
    }
    
}
