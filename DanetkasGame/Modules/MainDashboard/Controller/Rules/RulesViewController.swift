//
//  RulesViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 22/11/2021.
//

import UIKit

class RulesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var falseAssumptionBackgroundView: UIView!
    @IBOutlet weak var falseAssumptionView: UIView!

    @IBOutlet weak var specifyBackgroundView: UIView!
    @IBOutlet weak var specifyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: RulesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: RulesCollectionViewCell.Identifier)
        collectionView.register(UINib(nibName: GamePlayCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: GamePlayCollectionViewCell.Identifier)
        collectionView.register(UINib(nibName: ChallengeCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ChallengeCollectionViewCell.Identifier)
        collectionView.register(UINib(nibName: ExtraRulesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ExtraRulesCollectionViewCell.Identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        
        self.falseAssumptionBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        
        falseAssumptionBackgroundView.isHidden = true
        falseAssumptionView.layer.cornerRadius = 32.0
        
        self.specifyBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        
        specifyBackgroundView.isHidden = true
        specifyView.layer.cornerRadius = 32.0
    }
    
    @objc func dismissView(_ tapGesture: UIGestureRecognizer){
        tapGesture.view?.isHidden = true
    }

}

//MARK:- COLLECTIONVIEW DELEGATE DATASOURCE
extension RulesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RulesCollectionViewCell.Identifier, for: indexPath) as! RulesCollectionViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamePlayCollectionViewCell.Identifier, for: indexPath) as! GamePlayCollectionViewCell
            cell.delegate = self
            cell.gamePlayDelegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtraRulesCollectionViewCell.Identifier, for: indexPath) as! ExtraRulesCollectionViewCell
            cell.delegate = self
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeCollectionViewCell.Identifier, for: indexPath) as! ChallengeCollectionViewCell
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    //HORIZONTAL SPACING BETWEEN CELLS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //VERTICAL SPACING BETWEEN CELLS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension RulesViewController: RulesDelegate {
    
    func selectRulesOption(index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
    }
    
    func dismissScreen() {
        self.pop(completion: nil)
    }
    
}

extension RulesViewController: GamePlayDelegate {
    
    func falseButton() {
        falseAssumptionBackgroundView.isHidden = false
    }
    
    func specifyButton() {
        specifyBackgroundView.isHidden = false
    }
    
}
