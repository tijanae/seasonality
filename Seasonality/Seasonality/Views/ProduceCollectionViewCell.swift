//
//  ProduceCollectionViewCell.swift
//  Seasonality
//
//  Created by Phoenix McKnight on 12/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class ProduceCollectionViewCell: UICollectionViewCell {
    lazy  var photoImage:UIImageView = {
          let pi = UIImageView()
          pi.image = UIImage(systemName: "photo")
          pi.contentMode = .scaleToFill
          
          return pi
          
      }()
    
    lazy  var mark:UIImageView = {
             let pi = UIImageView()
             pi.image = UIImage(systemName: "xmark.circle")
             pi.contentMode = .scaleToFill
             
             return pi
             
         }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        contentView.addSubview(photoImage)
        contentView.addSubview(mark)
        produceImageConstraint()
        markConstraints()
    }
    
    private func produceImageConstraint() {
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    private func markConstraints() {
        mark.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        mark.topAnchor.constraint(equalTo: photoImage.bottomAnchor),
        mark.centerXAnchor.constraint(equalTo: photoImage.centerXAnchor),
        mark.widthAnchor.constraint(equalToConstant: 50),
            mark.heightAnchor.constraint(equalToConstant: 50),
            mark.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,constant: -10)
        ])
    }
}
