
import UIKit

class FoodCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var foodNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var calorieLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        foodNameLabel.font = bodyFont
        calorieLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        locationLabel.font = caption1Font
    }
    
}
