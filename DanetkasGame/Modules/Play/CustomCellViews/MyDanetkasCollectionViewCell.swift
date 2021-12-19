//
//  MyDanetkasCollectionViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 25/08/2021.
//

import UIKit

protocol MyDanetkasDelegate {
    func didSelect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class MyDanetkasCollectionViewCell: UICollectionViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var listTableView: UITableView!
    
    //MARK:- PROPERTIES
    var delegate: MyDanetkasDelegate?
    class var identifier: String {
        return "MyDanetkasCollectionViewCell"
    }
    
    var danetkas: [PlayViewModel.DanetkaModel]? {
        didSet {
            if danetkas != nil {
                self.listTableView.reloadData()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        searchView.layer.cornerRadius = searchView.frame.size.height / 2
        searchView.layer.borderColor = UIColor(hex: "#E8E8E8").cgColor
        searchView.layer.borderWidth = 1.0
        indicatorView.layer.cornerRadius = indicatorView.frame.height / 2
        
        listTableView.register(UINib(nibName: MyDanetkasTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MyDanetkasTableViewCell.identifier)
        listTableView.showsVerticalScrollIndicator = false
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.allowsSelection = true
    }

}


//MARK:- TABLEVIEW DELEGATE DATASOURCE
extension MyDanetkasCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.danetkas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyDanetkasTableViewCell.identifier, for: indexPath) as! MyDanetkasTableViewCell
        cell.danetka = self.danetkas?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(tableView, didSelectRowAt: indexPath)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if searchTextField.isFirstResponder {
            searchTextField.resignFirstResponder()
        }
        
    }
    
}
