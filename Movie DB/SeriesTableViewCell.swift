//
//  SeriesTableViewCell.swift
//  Movie DB
//
//  Created by Muneef M on 11/12/2015.
//  Copyright © 2015 com.mnf.moviedb. All rights reserved.
//

import UIKit
import Kingfisher
class SeriesTableViewCell: UITableViewCell,FloatRatingViewDelegate {
    
    @IBOutlet var titleName:UILabel!
    @IBOutlet var posterImage:UIImageView!
    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var releaseDateLabel:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var populate:JSON?{
        didSet{
            print("inside populate json")
            self.titleName.text = self.populate?["title"].string
            self.floatRatingView.emptyImage = UIImage(named: "StarEmpty")
            self.floatRatingView.fullImage = UIImage(named: "StarFull")
            self.floatRatingView.delegate = self
            self.floatRatingView.contentMode = UIViewContentMode.ScaleAspectFit
            self.floatRatingView.maxRating = 5
            self.floatRatingView.minRating = 0
            self.floatRatingView.editable = false
            self.floatRatingView.halfRatings = true
            self.floatRatingView.floatRatings = true
            self.floatRatingView.rating = (self.populate?["vote_average"].float)!

            self.releaseDateLabel.text = "Release Date:- "+(self.populate?["release_date"].string)!
            let util  = Utils()
            let posterUrl = util.IMAGE_BASE_URL+(self.populate?["poster_path"].string)!
            let URL = NSURL(string: posterUrl)!
            print("image url got is = "+posterUrl)
            print(URL)
            let imageP = UIImage(named: "movie_set")
            self.posterImage.kf_setImageWithURL(URL,placeholderImage: imageP)
        }
    }
    
    @IBAction func ratingTypeChanged(sender: UISegmentedControl) {
        self.floatRatingView.halfRatings = sender.selectedSegmentIndex==1
        self.floatRatingView.floatRatings = sender.selectedSegmentIndex==2
    }
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(ratingView: FloatRatingView, isUpdating rating:Float) {
        //self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(ratingView: FloatRatingView, didUpdate rating: Float) {
        //  self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }

}
