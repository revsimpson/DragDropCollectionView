//
//  ViewController.swift
//  DragDropCollectionView
//
//  Created by Richard Simpson on 07/05/2019.
//  Copyright © 2019 Richard Simpson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var numberArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    

    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else { break }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
           // Om het niet te laten verspringen moet je alleen de gesturePosition.x aanpassen en dat is het eigenlijk.
           // collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            var gesturePosition = gesture.location(in: gesture.view!)
            gesturePosition.x = (self.collectionView.frame.width / 2)
            collectionView.updateInteractiveMovementTargetPosition(gesturePosition)
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}
    
extension ViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DemoCollectionViewCell", for: indexPath) as! DemoCollectionViewCell
        cell.textLabel.text = String(numberArray[indexPath.row])
  //      cell.backgroundColor = UIColor(displayP3Red: 255/255, green: 122/255, blue: 100/255, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return numberArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = numberArray.remove(at: sourceIndexPath.item)
        numberArray.insert(item, at: destinationIndexPath.item)
        print(numberArray)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((self.view.frame.size.width)), height: 50)
    }
}

