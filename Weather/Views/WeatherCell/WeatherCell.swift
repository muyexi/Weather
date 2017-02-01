import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func setup(weather: Weather) {
        nameLabel.text = weather.name
        tempLabel.text = weather.temp.description + "°"
        
        tempLabel.heroID = weather.id.description
    }
    
}
