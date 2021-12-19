//
//  SettingsViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 22/08/2021.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- PROPERTIES
    fileprivate let settingOptions: [String] = [
                                    "My Account",
                                    "Language",
                                    "Contact",
                                    "FAQ",
                                    "About us",
                                    "Privacy and Terms"]
    private let spacing: CGFloat = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
}

//MARK:- UICOLLECTIONVIEW DELEGATE AND DATASOURCE
extension SettingsViewController: UICollisionBehaviorDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionsCollectionViewCell.identifier, for: indexPath) as! OptionsCollectionViewCell
        cell.titleLabel.text = settingOptions[indexPath.row]
        cell.titleLabel.textColor = Constant.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.15)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellHeight = collectionView.frame.size.width * 0.15
        let totalCellHeight = cellHeight * CGFloat(settingOptions.count)
        let spacingTotalHeight = spacing * CGFloat(settingOptions.count - 1)
        let totalHeightWithSpacing = totalCellHeight + spacingTotalHeight
        if totalHeightWithSpacing <= collectionView.frame.size.height {
            let totalHeight = collectionView.frame.size.height - totalHeightWithSpacing
            return UIEdgeInsets(top: totalHeight / 2 , left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0 , left: 0, bottom: 0, right: 0)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let VC = DanetkasHelper.getViewController(storyboard: .Authentication, identifier: .LoginVC)
            self.present(to: VC, completion: nil)
        case 1:
            let VC = DanetkasHelper.getViewController(storyboard: .Settings, identifier: .LanguageVC)
            self.present(to: VC, completion: nil)
        case 2:
            let VC = DanetkasHelper.getViewController(storyboard: .Settings, identifier: .ContactVC)
            self.present(to: VC, completion: nil)
        case 3:
            let VC = DanetkasHelper.getViewController(storyboard: .Settings, identifier: .FAQVC)
            self.present(to: VC, completion: nil)
        case 4:
            let VC = DanetkasHelper.getViewController(storyboard: .Settings, identifier: .AboutUsVC)
            self.present(to: VC, completion: nil)
        case 5:
            let VC = DanetkasHelper.getViewController(storyboard: .Settings, identifier: .PrivacyVC)
            self.present(to: VC, completion: nil)
        default:
            break
        }
    }
} 
