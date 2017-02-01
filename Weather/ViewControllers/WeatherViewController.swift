import UIKit
import Hero

class WeatherViewController: UIViewController {

    var weather: Weather?
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isHeroEnabled = true
        tempLabel.heroID = weather?.id.description
        
        if let weather = weather {
            title = weather.name
            
            mainLabel.text = weather.main
            tempMaxLabel.text = "↑ " + weather.tempMax.description + "°"
            tempMinLabel.text = "↓ " + weather.tempMin.description + "°"
            tempLabel.text = weather.temp.description + "°"
        }
    }
    
}

