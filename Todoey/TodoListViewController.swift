//
//  ViewController.swift
//  Todoey
//
//  Created by Saad Mashkoor Siddiqui on 02/03/2019.
//  Copyright © 2019 Saad Mashkoor Siddiqui. All rights reserved.
//

import UIKit

/* Changed name of the ViewController.swift file to TodoListViewController.swift
   This class inherits from UITableViewController instead of UIViewController. This
   is because the View in our app is a Table View, and so the class that controls what
   happens on this View must inherit from the UITableViewController class in order to
   inherit all the methods and attributes needed to modify the View. The name of the
   class and the file have been changed to reflect that this class is a controller
   for TodoListView.
 
   This means we do not have to explicitly define any protocols and delegates that
   we did in previous apps. Inheritance means we don't have to explictly link the
   IB outlets or set up delegates and data sourcs. Because of inheritance from
   UITableViewController, all these things are automated by Xcode
 */
class TodoListViewController: UITableViewController {

    // MARK: - ATTRIBUTES
    // mutable array of todos
    var itemArray = [ "Find Mike", "Buy Eggos", "Defeat Demogorgon" ]
    
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - TABLE VIEW DATA METHODS
    // method that defines how many TableViewCells need to be populated - one cell per item in list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }   // end function tableView( numberOfRowsInSection )
    
    // method that defines what each cell in the TableView should display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* create a new Cell object - the local tableView variable that we got
        from subclassing the TableViewController class. It's the same as creating an
        IBOutlet called tableView to refer to the Table View in the Storyboard
        Reusable cell that refers to the Storyboard element `ToDoItemCell` and
        is defined by the indexPath for the current row in the table */
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath )
        
        // Set the text in this cell to the corresponding text in the itemArray, using
        // the index of the itemArray specified by indexPath
        cell.textLabel?.text = itemArray[ indexPath.row ]
        
        // return the cell to the TableView to be displayed as a row
        return cell
        
    }   // end function tableView( cellForRowAt )
    
    
    // MARK: - TABLE VIEW DELEGATE METHODS
    // This function that is triggered every time the user selects a specific TableView row
    // Tells the delegate i.e. this class that a row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // toggle the checkmark for the selected cell
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }   // end if-else block to handle toggling of checkmark
        
        // remove the highlighting from the selected row
        tableView.deselectRow(at: indexPath, animated: true )
        
    }   // end function tableView didSelectRow
    
    // MARK: - ADD NEW ITEMS
    // IBAction that allows user to enter new todo using an popup with a textField
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        // local textField variable that is accessible inside both closures
        var textField = UITextField()

        // Create a new alert or popup with a specific title, an optional message/prompt, and a style
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert )
        
        // Define the action that should take place in the new alert
        let action = UIAlertAction( title: "Add Item", style: .default ) { (action) in
            // append the todo user has entered in the textField to the itemsArray
            self.itemArray.append( textField.text! )        // because inside a closure
            
            // update the TableView to show the newly added todo list item
            self.tableView.reloadData()
        }   // end trailing closure for UIAlertAction
        
        // add a textField to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField                  // assigning to wider scope
            
            print( textField.text )
        }   // end trailing closure for the alert's addTextField
        
        // add the action to the alert so that it is triggered at the right time
        alert.addAction( action )
        
        // Finally, show the alert
        present(alert, animated: true, completion: nil)
    }   // end IBAction AddButtonPressed
}   // end class TodoListViewController
