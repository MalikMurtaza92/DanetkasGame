//
//  DictionaryViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 27/08/2021.
//

import UIKit

class DictionaryViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var dictionaryTableView: UITableView!
    
    //MARK:- PROPERTIES
    var viewModel: DictionaryViewModel = DictionaryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        searchView.layer.cornerRadius = searchView.frame.size.height / 2
        searchView.layer.borderColor = UIColor(hex: "#E8E8E8").cgColor
        searchView.layer.borderWidth = 1.0
        
        dictionaryTableView.delegate = self
        dictionaryTableView.dataSource = self
        dictionaryTableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }

}

//MARK:- TABLEVIEW DELEGATE DATASOURCE
extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DictionaryTableViewCell.identifier, for: indexPath) as! DictionaryTableViewCell
        cell.word = viewModel.words[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.words[indexPath.row].isSelected == true {
            viewModel.words[indexPath.row].isSelected = false
        } else {
            viewModel.words[indexPath.row].isSelected = true
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
