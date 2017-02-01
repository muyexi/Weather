import UIKit
import ObjectMapper
import SVProgressHUD
import Hero

class WeatherTableViewController: UITableViewController {

    var weathers: [Weather] = []
    
    lazy var api: WeatherListAPI = {
        let api = WeatherListAPI()
        api.completionHandler = { [unowned self] json in
            self.weathers = Mapper<Weather>().mapArray(JSONArray: json)!
            
            SVProgressHUD.dismiss()
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
        api.failureHandler = { json in
            self.tableView.refreshControl?.endRefreshing()
        }
        
        return api
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Weather!"
        tableView.tableFooterView = UIView()
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        tableView.addSubview(refreshControl!)
        
        api.request()
        SVProgressHUD.show()
        
        navigationController?.isHeroEnabled = true
    }
    
    func refreshTable() {
        api.request()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = String(describing: WeatherCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: name) as? WeatherCell
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed(name, owner: self, options: nil)!.first as? WeatherCell
        }
        
        let weather = weathers[indexPath.row]
        cell!.setup(weather: weather)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let id = String(describing: WeatherViewController.self)
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id) as! WeatherViewController
        controller.weather = weathers[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
