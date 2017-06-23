//
//  ViewController.swift
//  exampleIOS11
//
//  Created by eric yu on 6/23/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDropInteractionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addInteraction(UIDropInteraction(delegate: self))
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        
        
        for dragItem in session.items {
            dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (obj, err) in
                
                if let err = err {
                    print("failed to load out dragged item;",err)
                    return
                }
                
                guard let draggedImage = obj as? UIImage else { return }
                
                
                //this call is background
                
                DispatchQueue.main.async{
                    let imageView = UIImageView(image: draggedImage)
                    self.view.addSubview(imageView)
                    imageView.frame = CGRect(x: 0, y: 0, width: draggedImage.size.width, height: draggedImage.size.height)
                    
                    let centerPoint = session.location(in: self.view)
                    imageView.center = centerPoint
                    
                    
                    
                }
                
            })
        }
    }
    
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        
        
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        
        
        
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    
}


