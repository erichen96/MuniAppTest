//
//  StationsViewController.swift
//  MuniApp
//
//  Created by Eric Chen on 3/17/22.
//

import UIKit


class StopCell: UITableViewCell {
    
}

class StationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let networking = Networking()
    
    var stops: [Stop] = []
    
    var route: Route?
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        //Populate lables, textfields, and other
        //If you do it from prepareForSegue the app will crash
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StopCell.self, forCellReuseIdentifier: "StopCell")
        navigationItem.title = route?.title
        
        guard let route = route else {
            return
        }
        
        //Inside tasks we can call asynchronous functions!
        Task{
            do {
            let routeConfig = try await networking.fetchRouteConfig(routeTag: route.tag)
                await MainActor.run{
                    stops = routeConfig.route.stop
                    tableView.reloadData()
                }
            } catch {
                print(error)
        
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell") as? StopCell else {
            return UITableViewCell()
        }
        let stop = stops[indexPath.row]
        cell.textLabel?.text = stop.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPredictionsSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let predicitionsViewController = segue.destination as? PredictionsViewController else {
            return
        }
        guard let indexPath = sender as? IndexPath else {
            return
        }
        let route = route
        let stop = stops[indexPath.row]
        
        predicitionsViewController.stop = stop
        print("Stop", stop)
        predicitionsViewController.route = route
        print("ROUTE:", route)
    }
}

