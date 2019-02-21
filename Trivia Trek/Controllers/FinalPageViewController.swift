//
//  FinalPageViewController.swift
//  MAD 2018-19
//
//  Created by Samrudh Shenoy on 2/17/19.
//  Copyright © 2019 Homestead FBLA. All rights reserved.
//

import UIKit
import FacebookShare
import FBSDKShareKit

class FinalPageViewController: UIViewController {
    
    @IBOutlet weak var shareButton: FBSDKShareButton!
    @IBOutlet weak var feedBackButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    var finalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if feedBackButton != nil {
            self.feedBackButton.layer.cornerRadius = 7
        }
        
        if homeButton != nil {
            self.homeButton.layer.cornerRadius = 7
        }
        
        let shareButton = FBSDKShareButton()
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://github.com/arthurlafrance/MustangGame")
        content.quote = "I scored \(finalScore) points on Trivia Trek!! You should give it a try too!"
        shareButton.shareContent = content
        shareButton.setTitle("Share your score", for: .normal)
        shareButton.center = view.center
        self.view.addSubview(shareButton)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onShareClicked(_ sender: UIButton) {
        do{
            var myContent = PhotoShareContent(photos: [Photo(image: UIImage(named: "MustangGameLogoBetter")!, userGenerated: false)])
            myContent.hashtag = Hashtag("#TriviaTrek")
            
            
            let shareDialog = ShareDialog(content: myContent)
            shareDialog.mode = .native
            shareDialog.failsOnInvalidData = true
            shareDialog.completion = { result in
                switch result {
                case .success:
                    print("Share succeeded")
                case .failed:
                    print("Share failed: check Facebook permissions and/or network settings")
                case .cancelled:
                    print("Share cancelled")
                }
            }
            
            try shareDialog.show()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func faceBookShare()
    {
        
        let content:LinkShareContent = LinkShareContent.init(url: URL.init(string: "https://github.com/arthurlafrance/MustangGame") ?? URL.init(fileURLWithPath: "https://github.com/arthurlafrance/MustangGame"), quote: "Share Your Trivia Trek Experience!!")
        
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .native
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            // Handle share results
        }
        do
        {
            try shareDialog.show()
        }
        catch
        {
            print("Exception")
            
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
