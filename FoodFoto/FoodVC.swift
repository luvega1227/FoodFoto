
import UIKit

class FoodVC: UITableViewController {
    
    var foodStore: FoodStore!
    var imageStore: ImageStore!
    
    @IBAction func addNewFood(_ sender: AnyObject) {
        // Create a new item and add it to the store
        let newFood = foodStore.createFood()
        
        // Figure out where that food is in the array
        if let index = foodStore.allFood.index(of: newFood) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodStore.allFood.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell
        
        cell.backgroundColor = .clear
        
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
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let food = foodStore.allFood[indexPath.row]
            
            let title = "Delete \(food.foodName)?"
            let meessage = "Are your sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: meessage, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                
                // Remove the food from the store
                self.foodStore.removeFood(food)
                
                // Remove the food's image from the image store
                self.imageStore.deleteImageForKey(food.foodKey)
                
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        foodStore.moveFoodAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "ShowFood" segue
        if segue.identifier == "ShowFood" {
            
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get the food associated with this row and pass it along
                let food = foodStore.allFood[row]
                let detailVC = segue.destination as! DetailVC
                detailVC.food = food
                detailVC.imageStore = imageStore
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
}

















