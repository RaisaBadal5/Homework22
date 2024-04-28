//
//  CountryCells.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import UIKit

class CountryCells: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.addSubview(nameLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(countryLabel)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let containerView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()
    
    let countryLabel: UILabel = {
        let img = UILabel()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.textColor =  UIColor.black
            label.text = "Undefined"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    func setUp() {
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
          containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
          containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
          containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
          
          nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
          nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
          nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
          nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
          
          countryLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
          countryLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
          countryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
          countryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
}
