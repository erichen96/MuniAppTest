//
//  ViewController.swift
//  MuniApp
//
//  Created by Eric Chen on 3/16/22.
//

import UIKit

class RouteCell: UITableViewCell {
    
}

class RoutesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let networking = Networking()
    
    var routes: [Route] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        //This function executes on the UI thread: Main queue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RouteCell.self, forCellReuseIdentifier: "RouteCell")
        super.viewDidLoad()
        networking.fetchRoutes { routes in
//            print(routes)
            self.update(with: routes)
        }
    }
    
    func update(with routes: [Route]){
        DispatchQueue.main.async{
            self.routes = routes
            self.tableView.reloadData() //Force reload, not used to reload a single cell/ add a cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell") as? RouteCell else {
            return UITableViewCell()
        }
        let route = routes[indexPath.row]
        cell.textLabel?.text = route.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToStationsSegue", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stationsViewController = segue.destination as? StationsViewController else {
            return
        }
        guard let indexPath = sender as? IndexPath else {
            return
        }
        let route = routes[indexPath.row]
        stationsViewController.route = route
    }
}

