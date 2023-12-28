//
//  ProdukTableViewCell.swift
//  ASG
//
//  Created by Rakha Aiman Mumtaz on 18/12/23.
//

import UIKit

class ProdukTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageProduk: UIImageView!
    
    @IBOutlet weak var produkName: UILabel!
    
    
    @IBOutlet weak var harga: UILabel!
    
    func configure(with toy: Mainan) {
        if let imageData = toy.image,
           let decodedData = Data(base64Encoded: imageData),
           let image = UIImage(data: decodedData) {
            imageProduk.image = image
        } else {

            imageProduk.image = UIImage(named: "defaultImage")
        }

        produkName.text = toy.namaMainan
        harga.text = "RP.\(toy.hargaMainan).000,00"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
