

import UIKit

class FoodVC: UITableViewController {
    
    var foodStore: FoodStore!
    var imageStore: ImageStore!
    
    @IBAction func addNewFood(sender: AnyObject) {
        // Create a new item and add it to the store
        let newFood = foodStore.createFood()
        
        // Figure out where that food is in the array
        if let index = foodStore.allFood.indexOf(newFood) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            // Insert this new row into the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodStore.allFood.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath) as! FoodCell
        
        cell.backgroundColor = .clearColor()
        
        // Update the labels for the new preferred text size
        cell.updateLabels()
        
        // Set the text on the cell with the descripition of the food that is at the nth index of food, where n = row this cell will appear in on the tableview
        let food = foodStore.allFood[indexPath.row]
        
        // Configure the cell with the Food
        cell.foodNameLabel.text = food.foodName
        cell.locationLabel.text = food.location
        cell.calorieLabel.text = "\(food.calories) cal."
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .Delete {
            let food = foodStore.allFood[indexPath.row]
            
            let title = "Delete \(food.foodName)?"
            let meessage = "Are your sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: meessage, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
            
                // Remove the food from the store
                self.foodStore.removeFood(food)
                
                // Remove the food's image from the image store
                self.imageStore.deleteImageForKey(food.foodKey)
            
                // Also remove that row from the table view with an animation
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // Update the model
        foodStore.moveFoodAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If the triggered segue is the "ShowFood" segue
        if segue.identifier == "ShowFood" {
            
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get the food associated with this row and pass it along
                let food = foodStore.allFood[row]
                let detailVC = segue.destinationViewController as! DetailVC
                detailVC.food = food
                detailVC.imageStore = imageStore
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
}

















