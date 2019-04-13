//
//  MainViewCell.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import UIKit

final class MainViewCell: UITableViewCell {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
    
    func update(with item: StoryType) {
        titleLabel.text = item.title
        hostLabel.text = item.host
    }
    
    func setIcon(_ icon: IconProtocol) {
        iconImageView.loadImage(with: icon.url.absoluteString)
    }
    
}
