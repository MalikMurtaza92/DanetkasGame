//
//  DanetkaViewController.swift
//  DanetkasGame
//
//  Created by Murtaza Mehmood on 12/12/2021.
//

import UIKit

class DanetkaViewController: BaseViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - PROPERTIES
    let viewModel: DanetkasViewModel = DanetkasViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        collectionView.register(DanetkasCollectionViewCell.nib, forCellWithReuseIdentifier: DanetkasCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchDanetkas()
    }
    
    func fetchDanetkas() {
        viewModel.fetchDanetkas { result, error in
            if error == nil {
                self.viewModel.danetkaListing = result?.listing ?? []
                self.collectionView.reloadData()
            } else {
                self.showSimpleAlert(title: Constant.title, message: error)
            }
        }
    }
}

//MARK: - COLLECTIONVIEW DELEGATE DATASOURCE
extension DanetkaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DanetkasCollectionViewCell.identifier, for: indexPath) as! DanetkasCollectionViewCell
        cell.model = DanetkasCellViewModel(danetka: self.viewModel.danetkaListing?[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.danetkaListing?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.95, height: 120)
    }
    
    //HORIZONTAL SPACING BETWEEN CELLS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //VERTICAL SPACING BETWEEN CELLS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
