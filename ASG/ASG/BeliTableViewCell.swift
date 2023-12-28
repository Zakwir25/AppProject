//
//  BeliTableViewCell.swift
//  ASG
//
//  Created by Rakha Aiman Mumtaz on 20/12/23.
//

import UIKit

protocol BeliTableViewCellDelegate: AnyObject {
    func didUpdateQuantity(for mainan: Mainan)
    func didBuyButtonTapped(for mainan: Mainan)
}

class BeliTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imageMainan: UIImageView!
    
    @IBOutlet weak var namaMainan: UILabel!
    
    
    @IBOutlet weak var hargaMainan: UILabel!
    
    var delegate: BeliTableViewCellDelegate?
    var mainan: Mainan?
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func buyBtn(_ sender: Any) {
        if let mainan = mainan {
                delegate?.didBuyButtonTapped(for: mainan)
            } else {
                print("Error: Mainan is nil")
            }
    }
    
    func configure(with mainan: Mainan) {
        self.mainan = mainan
        
        if let imageData = mainan.image,
           let decodedData = Data(base64Encoded: imageData),
           let image = UIImage(data: decodedData) {
            imageMainan.image = image
        } else {
            imageMainan.image = UIImage(named: "defaultImage")
        }
        
        namaMainan.text = mainan.namaMainan
        hargaMainan.text = "RP.\(mainan.hargaMainan).000,00"
    }
    
}
