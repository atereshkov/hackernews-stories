//
//  MainViewCell.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

final class MainViewCell: UITableViewCell {
    
    @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hostLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        loadingSpinner.alpha = 0
    }
    
    func update(with item: StoryType) {
        titleLabel.text = item.title
        hostLabel.text = item.host
    }
    
    func setIcon(_ icon: IconProtocol?, noImage: UIImage? = nil) {
        if let icon = icon {
            iconImageView.loadImage(with: icon.url.absoluteString, errorImage: noImage)
            iconImageView.alpha = 0
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.iconImageView.alpha = 1.0
                self?.loadingSpinner.alpha = 0
            }, completion: { [weak self] _ in
                self?.loadingSpinner.stopAnimating()
            })
        } else {
            iconImageView.image = nil
            iconImageView.alpha = 0
            loadingSpinner.alpha = 1.0
            loadingSpinner.startAnimating()
        }
    }
    
    func setTime(_ time: String?) {
        timeLabel.text = time
    }
    
}
