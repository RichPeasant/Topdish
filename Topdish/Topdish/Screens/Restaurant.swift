//
//  Restaurant.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Restaurant {
    var title: String
    var featuredImage: UIImage
    var typeOfCuisine: String
    var rating: Double
    
    init(title: String, featuredImage: UIImage, typeOfCuisine: String, rating: Double ) {
        self.title = title
        self.featuredImage = featuredImage
        self.typeOfCuisine = typeOfCuisine
        self.rating = rating
    }
    
    /* Queries the database to return the ratings for a single restaurant
     * goes through all the dishes and returns a double which is the average user rating */
    static func getRating(restaurant: String, completion: @escaping (Double) -> Void) {
        let childString : String = "menu/" + restaurant
        var counter: Double = 0
        var totalRating: Double = 0

        Database.database().reference().child(childString).observeSingleEvent(of: .value) { snapshot in
            let singleRestaurant = snapshot.children
            while let dishes = singleRestaurant.nextObject() as? DataSnapshot {
                let dishReviews = (dishes.childSnapshot(forPath: "user reviews")).children
                while let review = dishReviews.nextObject() as? DataSnapshot {
                    let singleRating = review.childSnapshot(forPath: "rating").value
                    totalRating += (singleRating as AnyObject).doubleValue
                    counter += 1
                }
            }
            completion(totalRating / counter)
        }
    }

    /* Queries the database and returns the top highest rated restaurants */
    static func getTopPlaces() -> [Restaurant] {
        return [
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!, typeOfCuisine: "placeholder", rating: 5.0),
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!, typeOfCuisine: "placeholder", rating: 5.0),
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!, typeOfCuisine: "placeholder", rating: 5.0),
                                  
        ]
    }
    
    /* Queries the database and returns a list of restaurants within a certain km, sorted by nearest */
    static func getNearby() -> [Restaurant] {
        return [
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!, typeOfCuisine: "placeholder", rating: 5.0),
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!, typeOfCuisine: "placeholder", rating: 5.0),
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!, typeOfCuisine: "placeholder", rating: 5.0),
                                  
        ]
    }
    
    /* Queries the database and returns a list of restaurants with ongoing offers
     * Based on offer start and end date */
    static func getExclusiveOffers() -> [Restaurant] {
        return [
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!, typeOfCuisine: "placeholder", rating: 5.0),
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!, typeOfCuisine: "placeholder", rating: 5.0),
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!, typeOfCuisine: "placeholder", rating: 5.0),
                                  
        ]
    }
}
