
import UIKit

class FoodCell: UITableViewCell {
    
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var calorieLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        foodNameLabel.font = bodyFont
        calorieLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        locationLabel.font = caption1Font
    }
    
}