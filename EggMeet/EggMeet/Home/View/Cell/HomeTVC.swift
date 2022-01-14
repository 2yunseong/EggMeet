//
//  HomeTVCTableViewCell.swift
//  EggMeet
//
//  Created by asong on 2022/01/11.
//

import UIKit

class HomeTVC: UITableViewCell {
    //static let identifier = "HomeTVC"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var growthCostLabel: UILabel!
    @IBOutlet weak var mentorGrowthPointLabel: UILabel!
    @IBOutlet weak var firstCategoryLabel: UILabel!
    @IBOutlet weak var secondCategoryLabel: UILabel!
    @IBOutlet weak var firstHashtagLabel: UILabel!
    @IBOutlet weak var secondHashtagLabel: UILabel!
    @IBOutlet weak var thirdHashtagLabel: UILabel!
    @IBOutlet weak var fourthHashtagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension HomeTVC {
    func initCell(image: String, nickname: String, rating: String, mentorGrowthPoint: Int, firstCategory: Category , location: Location, isOnline: Bool, age: Int, sex: Sex){
        profileImageView.image = UIImage(named: image)
        starImageView.image = UIImage(named: rating)
        
        nicknameLabel.text = nickname
        mentorGrowthPointLabel.text = "\(mentorGrowthPoint) 포인트"
        firstCategoryLabel.text = "\(firstCategory)"
        
        switch location {
            case .ALL : firstHashtagLabel.text = "#전체"
            default :firstHashtagLabel.text = "#\(location)"
        }
        
        switch isOnline{
            case true : secondHashtagLabel.text = "#온라인"
            case false : secondHashtagLabel.text = "#오프라인" }
        
        thirdHashtagLabel.text = "#\(age)대"
        
        switch sex {
        case .UNDEFINED : fourthHashtagLabel.text = ""
        case .FEMALE : fourthHashtagLabel.text = "#여성"
        case .MALE : fourthHashtagLabel.text = "#남성"
        }
    }
}
