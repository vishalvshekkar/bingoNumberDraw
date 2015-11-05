//
//  ViewController.swift
//  Bingo Draw
//
//  Created by Vishal V Shekkar on 06/11/15.
//  Copyright © 2015 Vishal V Shekkar. All rights reserved.
//

import UIKit

var drawnNumbers : [Int] = []

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var drawnNumbersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawnNumbersCollectionView.delegate = self
        drawnNumbersCollectionView.dataSource  = self

        self.navigationItem.title = "Bingo"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetAction(sender: AnyObject) {
        let alert = UIAlertController(title: "Reset", message: "Are you sure you want to reset generated numbers?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Reset", style: UIAlertActionStyle.Destructive, handler: { [weak self] (action) -> Void in
            drawnNumbers = []
            self?.drawnNumbersCollectionView.reloadData()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func drawAction(sender: AnyObject) {
        if let randomNumberGenerated = getRandomNumber() {
            drawnNumbers.append(randomNumberGenerated)
            drawnNumbersCollectionView.reloadData()
        }
        else {
            let alert = UIAlertController(title: "Finished", message: "You generated all possible numbers.\nReset to start over.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drawnNumbers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let drawnCell = drawnNumbersCollectionView.dequeueReusableCellWithReuseIdentifier("drawnNumbers", forIndexPath: indexPath) as! DrawnNumbersCell
        drawnCell.drawnNumberLabel.text = "\(drawnNumbers[indexPath.item])"
        return drawnCell
    }
    
    func getRandomNumber() -> Int? {
        var randomNumber = randomInt(minimumInt, max: maximumInt)
        if drawnNumbers.count <= maximumInt - minimumInt {
            while drawnNumbers.contains(randomNumber) {
                randomNumber = randomInt(minimumInt, max: maximumInt)
            }
            return randomNumber
        }
        else {
            return nil
        }
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }

}

