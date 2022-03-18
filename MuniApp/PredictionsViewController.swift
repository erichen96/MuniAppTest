//
//  PredictionsViewController.swift
//  MuniApp
//
//  Created by Eric Chen on 3/17/22.
//

import UIKit

class PredictionCell: UITableViewCell {
    
}

class PredictionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let networking = Networking()

    var route: Route?
    var stop: Stop?
    var time: Time?
    var predictions: [Minutes] = []
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        //Populate lables, textfields, and other
        //If you do it from prepareForSegue the app will crash
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PredictionCell.self, forCellReuseIdentifier: "PredictionCell")
        
        navigationItem.title = stop?.title
        
        guard let stop = stop else {
            return
        }
        guard let route = route else {
            return
        }
        Task{
            do{
                let predictionConfig = try await networking.fetchPredictionConfig(routeTag:route.tag, stopId: stop.tag)
                await MainActor.run {
                    predictions = predictionConfig.predictions.minutes
                    print(predictions)
                    tableView.reloadData()
                }
            } catch {
                print(error)
                print("ITS ME")
            }
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        predictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PredictionCell") as? PredictionCell else {
            return UITableViewCell()
        }
        let prediction = predictions[indexPath.row]
        cell.textLabel?.text = String(prediction.min)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPredictionsSegue", sender: indexPath)
    }
}
