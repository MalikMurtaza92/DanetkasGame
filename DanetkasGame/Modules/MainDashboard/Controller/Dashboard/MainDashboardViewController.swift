//
//  MainDashboardViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 22/08/2021.
//

import UIKit

class MainDashboardViewController: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var thinkingImage: UIImageView!
    @IBOutlet weak var popupView: UIView!
    
    
    
    //MARK:- PROPERTIES
    private var isRigolettoUp: Bool = false
    private let spacing: CGFloat = 10.0
    private var thinkingImageHeight: CGFloat = 0.0
    private let options: [String] = ["Play",
                                     "What is Danetkas?",
                                     "Rules",
                                     "Dictionary",
                                     "Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.thinkingImageHeight = self.thinkingImage.frame.size.height
        self.hideThinkingImage()
    }
    
    fileprivate func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let longPressGesture = UITapGestureRecognizer(target: self, action: #selector(tapImageGesture))
        thinkingImage.isUserInteractionEnabled = true
        thinkingImage.addGestureRecognizer(longPressGesture)
        
        popupView.isHidden = true
    }
    
    fileprivate func hideThinkingImage() {
        
        let rotation = CGAffineTransform(rotationAngle: (14 * (CGFloat(Double.pi) / 180)))
        let translation = CGAffineTransform(translationX: 0.0, y: self.thinkingImageHeight * 0.478)
        self.thinkingImage.transform = rotation.concatenating(translation)
    }

    @objc func tapImageGesture(_ gesture: UITapGestureRecognizer) {
        if isRigolettoUp {
            UIView.animate(withDuration: 0.23, delay: 0.0, options: [.curveEaseIn], animations: {
                self.hideThinkingImage()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.23, delay: 0.0, options: [.curveEaseIn], animations: {
                self.thinkingImage.transform = .identity
            }, completion: nil)
        }
        isRigolettoUp = !isRigolettoUp
    }
    
    
    @IBAction func isMasterPressed(_ sender: UIButton) {
        self.popupView.isHidden = true
        Utility.shared.isMaster = true
        Utility.shared.isInvestigator = false
        let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .PlayVC)
        self.present(to: VC, completion: nil)
    }
    
    @IBAction func isInvestigatorPressed(_ sender: UIButton) {
        self.popupView.isHidden = true
        Utility.shared.isMaster = false
        Utility.shared.isInvestigator = true
        let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .DanetkasVC)
        self.present(to: VC, completion: nil)
    }
    
    @IBAction func rulesPressed(_ sender: UIButton) {
        self.popupView.isHidden = true
        let VC = DanetkasHelper.getViewController(storyboard: .Dashboard, identifier: .RulesVC)
        self.present(to: VC, completion: nil)
    }
    
    @IBAction func closePopupView(_ sender: UIButton) {
        self.popupView.isHidden = true
    }
}

//MARK:- UICOLLECTIONVIEW DELEGATE DATASOURCE
extension MainDashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionsCollectionViewCell.identifier, for: indexPath) as! OptionsCollectionViewCell
        cell.titleLabel.text = options[indexPath.row]
        cell.isScalingFactor = true
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width * 0.2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellHeight = collectionView.frame.size.width * 0.2
        let totalCellHeight = cellHeight * CGFloat(options.count)
        let spacingTotalHeight = spacing * CGFloat(options.count - 1)
        let totalHeightWithSpacing = totalCellHeight + spacingTotalHeight
        let totalHeight = collectionView.frame.size.height - totalHeightWithSpacing
        return UIEdgeInsets(top: totalHeight / 2 , left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
//            let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .PlayVC)
//            self.present(to: VC, completion: nil)
            self.popupView.isHidden = false
        case 1:
            let VC = DanetkasHelper.getViewController(storyboard: .Dashboard, identifier: .DanetkasVC)
            self.present(to: VC, completion: nil)
        case 2:
            let VC = DanetkasHelper.getViewController(storyboard: .Dashboard, identifier: .RulesVC)
            self.present(to: VC, completion: nil)
        case 3:
            let VC = DanetkasHelper.getViewController(storyboard: .Dashboard, identifier: .DictionaryVC)
            self.present(to: VC, completion: nil)
        case 4:
            let VC = DanetkasHelper.getViewController(storyboard: .Settings, identifier: .SettingsVC)
            self.present(to: VC, completion: nil)
        default:
            break
        }
    }
}
