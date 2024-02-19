//
//  CryptoTableViewCell.swift
//  CryptoApp-MVVM-RxSwift
//
//  Created by Mehmet Emin Fırıncı on 19.02.2024.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var item : Crypto!{
        didSet{
            self.name.text = item.currency
            self.price.text = item.price
        }
    }

}
