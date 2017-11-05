//
//  ViewController.swift
//  ExerciseList
//
//  Created by Timothee MATO on 11/5/17.
//  Copyright © 2017 TimotheeMato. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UITableViewController {    
    private let tableViewCellClassName = "ExerciseCell"
    private let dataHandler = DataHandler()
    private var exerciseList = [Exercise]()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dataHandler.getAllExercises(completion: { response in
            self.exerciseList = response
            self.tableView.reloadData()
        }, failure: {
            print("Error")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK:- TableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellClassName) as! ExerciseCell
        let exercise = exerciseList[indexPath.row]
        cell.nameLabel.text = exercise.name
        cell.thumbImageView.sd_setImage(with: URL(string: exercise.imageUrl!), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

