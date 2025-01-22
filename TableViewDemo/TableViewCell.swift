//
//  TableViewCell.swift
//  TableViewDemo
//
//  Created by Manish Kumar on 22/01/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var videoImageView = UIImageView()
    var videoTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(videoImageView)
        addSubview(videoTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView() {
        videoImageView.layer.cornerRadius = 16
        videoImageView.clipsToBounds = true
        videoImageView.contentMode = .scaleAspectFill
        videoImageView.image = UIImage(systemName: "heart.fill")
    }
    
    private func configureTitleLabel() {
        videoTitleLabel.text = "Testing 123"
        videoTitleLabel.numberOfLines = 0
        videoTitleLabel.adjustsFontSizeToFitWidth = true
        videoTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    private func setImageConstraints() {
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            videoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            videoImageView.heightAnchor.constraint(equalToConstant: 80),
            videoImageView.widthAnchor.constraint(equalTo: videoImageView.heightAnchor, multiplier: 16/9)
        ])
    }
    
    private func setTitleLabelConstraints() {
        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            videoTitleLabel.leadingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: 20),
            videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            videoTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 80)
        ])
    }
    
    func configure(image: UIImage?, title: String) {
        videoImageView.image = image
        videoTitleLabel.text = title
    }
}
