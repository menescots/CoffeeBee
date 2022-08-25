//
//  CollectionViewCell.swift
//  CoffeeBee
//
//  Created by Agata Menes on 23/08/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var coffeeMethodImageView: UIImageView!
    @IBOutlet var coffeeMethodLabel: UILabel!
    
}

extension CollectionViewCell{

   func highlightEffect(){
      self.layer.borderWidth = 2.0
      self.layer.borderColor = UIColor.lightGray.cgColor
   }

   func removeHighlight(){
      
      self.layer.borderColor = UIColor.clear.cgColor
   }

}
