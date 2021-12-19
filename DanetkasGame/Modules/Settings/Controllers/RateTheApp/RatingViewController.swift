//
//  RatingViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 28/08/2021.
//

import UIKit

class RatingViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var ratingTableView: UITableView!
    
    //MARK:- PROPERTIES
    let ratingViewModel = RatingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    fileprivate func setupUI() {
        ratingTableView.delegate = self
        ratingTableView.dataSource = self
        ratingTableView.allowsSelection = false
    }
}
//MARK:- TABLEVIEW DELEGATE AND DATASOURCE
extension RatingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingViewModel.ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.identifier, for: indexPath) as! RatingTableViewCell
        cell.ratings = ratingViewModel.ratings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114.0
    }
}
