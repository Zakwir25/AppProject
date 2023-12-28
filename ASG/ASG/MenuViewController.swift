//
//  MenuViewController.swift
//  ASG
//
//  Created by Rakha Aiman Mumtaz on 18/12/23.
//

import UIKit
import CoreData

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToyCell", for: indexPath) as! ProdukTableViewCell

               let toy = toys[indexPath.row]
               cell.configure(with: toy)

               return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                deleteToy(at: indexPath)
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            handleCellSelection(at: indexPath)
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    var toys: [Mainan] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchDataFromCoreData()
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataFromCoreData()
        tableView.reloadData()
        
    }
    
    
    @IBAction func addBtn(_ sender: Any) {
        performSegue(withIdentifier: "NextAdd", sender: self)
        
    }
    
    
    func fetchDataFromCoreData() {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }

           let context = appDelegate.persistentContainer.viewContext

           let fetchRequest: NSFetchRequest<Mainan> = Mainan.fetchRequest()

           do {
               toys = try context.fetch(fetchRequest)
           } catch {
               print("Error fetching data from Core Data: \(error)")
           }
       }
    
    func deleteToy(at indexPath: IndexPath) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let context = appDelegate.persistentContainer.viewContext
            let toyToDelete = toys[indexPath.row]

            context.delete(toyToDelete)

            do {
                try context.save()
                toys.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting data from Core Data: \(error)")
            }
        }
    
    func handleCellSelection(at indexPath: IndexPath) {
            
            let selectedToy = toys[indexPath.row]

        
            performSegue(withIdentifier: "NextAdd", sender: selectedToy)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "NextAdd", let addToysViewController = segue.destination as? AddToysViewController {
                addToysViewController.toyToEdit = sender as? Mainan
            }
        }
    
}
