//
//  NewsCell.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    var data: News? {
        didSet {
            if let news = data {
                titleLabel.text = news.webTitle
                dateLabel.text = news.webPublicationDateInAgoFormate
                DispatchQueue.main.async {
                    self.bodyLabel.attributedText = news.fields?.bodyAttributed
                }
                // Fetch Image Based on Thumbnail URL
                thumbnailImageView.imageFromURLWithCache(news.fields?.thumbnail)
            }
        }
    }
    
    static let identifier = "NewsCell"
    
}

