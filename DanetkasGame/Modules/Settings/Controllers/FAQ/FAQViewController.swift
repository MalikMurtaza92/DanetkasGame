//
//  FAQViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/10/2021.
//

import UIKit

class FAQViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func contactUSButton(_ sender: UIButton) {
        
    }
}

//MARK:- TABLEVIEW DELEGATE AND DATASOURCE
extension FAQViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as! FAQTableViewCell
        cell.configureCell(indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

//MARK:- FAQ TABLEVIEW CELL DELEGATE
extension FAQViewController: FAQTableViewCellDelegate {
    
    func expendQuestion(cell: UITableViewCell, indexPath: IndexPath) {
        
    }
    
}
