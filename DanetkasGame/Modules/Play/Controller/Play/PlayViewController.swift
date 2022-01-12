//
//  PlayViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 25/08/2021.
//

import UIKit

class PlayViewController: BaseViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var menuListCollectionView: UICollectionView!
    @IBOutlet weak var rulesView: UIView!
    @IBOutlet weak var rulesOkay: UIButton!
    @IBOutlet weak var showAgainAlert: UIButton!
    
    //MARK:- PROPERTIES
    private let types: [String] = ["My Danetkas",
                                   "More Danetkas",
                                   "Make my Danetkas"]
    var selectedMenu: Int = 0
    var isRiddleImage: Bool = false
    var riddleImage: UIImage?
    var answerImage: UIImage?
    
    var viewModel: PlayViewModel = PlayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.danetkas = nil
    }
    
    fileprivate func setupUI() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        rulesOkay.layer.cornerRadius = rulesOkay.frame.height / 2
        rulesView.isHidden = true
        
        menuListCollectionView.delegate = self
        menuListCollectionView.dataSource = self
        menuListCollectionView.isPagingEnabled = true
        menuListCollectionView.allowsSelection = true
        menuListCollectionView.isScrollEnabled = false
        menuListCollectionView.register(UINib(nibName: MyDanetkasCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyDanetkasCollectionViewCell.identifier)
        menuListCollectionView.register(UINib(nibName: MoreDanetkasCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MoreDanetkasCollectionViewCell.identifier)
        menuListCollectionView.register(UINib(nibName: MakeMyDanetkaCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MakeMyDanetkaCollectionViewCell.identifier)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        if Utility.shared.user == nil {
            fetchMyDanetkas()
        } else {
            fetchLoginMyDanetkas()
        }
    }
    
    @IBAction func rulesButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.rulesView.isHidden = true
        }
        
        let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .MyDanetkaVC)
        self.present(to: VC, completion: nil)
    }
    
    @IBAction func showRuleViewAgain(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(UIImage(named: "selected"), for: .normal)
            Utility.shared.playRulePopUp = true
        } else {
            sender.setImage(UIImage(named: "unselected"), for: .normal)
            Utility.shared.playRulePopUp = false
        }
    }
    
    //MARK:- API
    func fetchMyDanetkas() {
        guard viewModel.danetkas == nil || viewModel.danetkas?.count == 0 else {
            return
        }
        showProgress()
        viewModel.fetchMyDanetkas { list, error in
            self.hideProgress()
            if error == nil {
                self.menuListCollectionView.reloadData()
            } else {
                self.showSimpleAlert(title: Constant.title, message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func fetchLoginMyDanetkas() {
        guard viewModel.loginDantkas == nil || viewModel.loginDantkas?.count == 0 else {
            return
        }
        showProgress()
        viewModel.fetchLoginMyDanetkas { list, error in
            self.hideProgress()
            if error == nil {
                self.menuListCollectionView.reloadData()
            } else {
                self.showSimpleAlert(title: Constant.title, message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func fetchMoreDanetkas() {
        guard viewModel.moreDanetkas == nil || viewModel.moreDanetkas?.count == 0 else {
            return
        }
        showProgress()
        viewModel.fetchMoreDanetkas { list, error in
            self.hideProgress()
            if error == nil {
                self.menuListCollectionView.reloadData()
            } else {
                self.showSimpleAlert(title: Constant.title, message: error?.localizedDescription ?? "")
            }
        }
    }
    
    
}


//MARK:- COLLECTIONVIEW DELEGATE DATASOURCE
extension PlayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCollectionView {
            return types.count
        } else {
            return types.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
            cell.titleLabel.text = types[indexPath.row]
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyDanetkasCollectionViewCell.identifier, for: indexPath) as! MyDanetkasCollectionViewCell
                cell.delegate = self
                cell.danetkas = viewModel.danetkas
                cell.index = indexPath.row
                return cell
            } else if indexPath.row == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreDanetkasCollectionViewCell.identifier, for: indexPath) as! MoreDanetkasCollectionViewCell
                cell.delegate = self
                cell.danetkas = viewModel.moreDanetkas
                cell.index = indexPath.row
                return cell
            }

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeMyDanetkaCollectionViewCell.identifier, for: indexPath) as! MakeMyDanetkaCollectionViewCell
            cell.delegate = self
            return cell
        }
    

    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuCollectionView {
            return CGSize(width: self.view.frame.width / 3, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            selectedMenu = indexPath.row
            if selectedMenu == 0 {
                self.fetchMyDanetkas()
            } else if selectedMenu == 1{
                self.fetchMoreDanetkas()
            }
            self.menuListCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

//COLLECTIONVIEW DELEGATE
extension PlayViewController: MyDanetkasDelegate {
    
    func didSelect(_ tableView: UITableView,index: Int?,didSelectRowAt indexPath: IndexPath, danetka: Danetka?) {
        if index == 0 {
            if Utility.shared.isPlayAsGuest ?? false {
                if Utility.shared.playRulePopUp ?? false {
                    let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .MyDanetkaVC) as! MyDanetkasViewController
                    VC.isFromMyDanetkas = true
                    VC.danetka = danetka
                    self.present(to: VC, completion: nil)
                } else {
                    self.rulesView.isHidden = false
                }
                
            } else if Utility.shared.user == nil {
                self.showToastAlert(title: Constant.title, message: "Please SignIn / SignUp or play as Guest")
            } else {
                let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .MyDanetkaVC)
                self.present(to: VC, completion: nil)
            }
        } else {
            if Utility.shared.user == nil {
                self.showToastAlert(title: Constant.title, message: "Please SignIn / SignUp or play as Guest")
            } else {
                let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .MyDanetkaVC) as! MyDanetkasViewController
                VC.danetka = danetka
                self.present(to: VC, completion: nil)
            }
        }
    }
    
}

//MARK: - MAKE MY DANETKAS DELEGATE
extension PlayViewController: MakeMyDanetkaCollectionViewCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getImage(){
        let alert = UIAlertController(title: "Select option", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style:  .default, handler: { _ in
            
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openRiddleImage() {
        isRiddleImage = true
        getImage()
    }
    
    func openAnswerImage() {
        isRiddleImage = false
        getImage()
    }
    
    func submitDanetka(danetkas: MakeDanetka?) {
        
        if Utility.shared.isPlayAsGuest ?? false {
            self.rulesView.isHidden = false
        } else if Utility.shared.user == nil {
            self.showToastAlert(title: Constant.title, message: "Please SignIn / SignUp or play as Guest")
        } else {
        
        
        print(Utility.shared.user?.id ?? 1)
        let param = ["title":danetkas?.title ?? "",
                     "answer":danetkas?.answer ?? "",
                     "image":"image",
                     "answerImage":"answerImage",
                     "hint":"Hint",
                     "question":"Question",
                     "learnMore":"Learn More",
                     "masterId":"87"]
            viewModel.makeMyDanetka(parameter: param, images: [self.riddleImage!, self.answerImage!])
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            if isRiddleImage {
                self.riddleImage = image
            } else {
                self.answerImage = image
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
