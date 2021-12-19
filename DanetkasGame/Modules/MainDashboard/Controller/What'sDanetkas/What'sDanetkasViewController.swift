//
//  What'sDanetkasViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 26/08/2021.
//

import UIKit

class What_sDanetkasViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        let descriptionString = """
                                Danetkas - musical stories is a quiz cooperative game where you need to find stories based on a hint and a picture. You don’t need to  be a musician. You just need to think critically and make smart questions. Even if you have a PhD in music history, you will still discover new fascinating things since many stories are not widely known. And even if you miraculously do know all the stories, the enigmatic hints will still make the game interesting.

                                    In Danetkas you will find real stories from classical composer’s lives, learn musical facts, instruments and also how to behave at a concert. Find out how a balloon inspired people to learn music, how a dead composer made a woman poison herself or how a symphony sent everyone on holidays. You will end up knowing facts about classical music and be able to impress your friends with fun anecdotes. You will find a whole  new world, where classical music is interesting, weird and unexpected. Don’t hesitate to go online and listen to the music you just learnt about.
                                """
//        let danetkas = "Danetkas"
//        
//        let attributedString = NSMutableAttributedString(string: descriptionString)
        let mutableParagraph = NSMutableParagraphStyle()
        mutableParagraph.alignment = .justified
        
        let mutableAttributedString = NSMutableAttributedString(string: descriptionString, attributes: [.font: UIFont(name:Poppins.Regular.rawValue , size: 16)! as UIFont, .foregroundColor: Constant.blue,.paragraphStyle: mutableParagraph])
        
//        let danetkasWordRange = (descriptionString as NSString).range(of: danetkas)
//
////        mutableAttributedString.setAttributes([.font : UIFont(name:Poppins.Medium.rawValue , size: 16)! as UIFont, .foregroundColor : Constant.blue], range: danetkasWordRange)
        
        self.descriptionLabel.attributedText = mutableAttributedString
    }

}
