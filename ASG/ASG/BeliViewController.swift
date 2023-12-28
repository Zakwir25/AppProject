//
//  BeliViewController.swift
//  ASG
//
//  Created by Rakha Aiman Mumtaz on 20/12/23.
//

import UIKit
import CoreData

class BeliViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BeliTableViewCellDelegate {
    
    func didBuyButtonTapped(for mainan: Mainan) {
            mainan.jumlah += 1
            updatePrices()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return belanjaItems.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BeliCell", for: indexPath) as! BeliTableViewCell
            cell.configure(with: belanjaItems[indexPath.row])
            cell.delegate = self
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 250.0
        }
        
        func didUpdateQuantity(for mainan: Mainan) {
            updatePrices()
        }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var jumlahMainan: UILabel!
    
    
    @IBOutlet weak var hargaMainan: UILabel!
    
    var belanjaItems: [Mainan] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchDataFromCoreData()
        updatePrices()
        
    }
    
    func fetchDataFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Mainan> = Mainan.fetchRequest()
        
        do {
            belanjaItems = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data from Core Data: \(error)")
        }
    }
    
    func updatePrices() {
            var totalQuantity = 0
            var totalPrice = 0

            for mainan in belanjaItems {
                totalQuantity += Int(mainan.jumlah)
                totalPrice += Int(mainan.hargaMainan) * Int(mainan.jumlah)
            }

            jumlahMainan.text = "\(totalQuantity)"
            hargaMainan.text = "RP.\(totalPrice).000,00"
        }
    

}
