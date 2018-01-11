//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by 何品泰高 on 2018/1/10.
//  Copyright © 2018年 何品泰高. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController,UISplitViewControllerDelegate {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.theme == nil{
                return true
            }
        }
        return false
    }
    
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController{
            if let themeName = (sender as?UIButton)?.currentTitle,let theme = themes[themeName]{
                cvc.theme = theme
            }else if let cvc = lastSeguedToConcentrationViewController{ // 中途更换theme
                if let themeName = (sender as?UIButton)?.currentTitle,let theme = themes[themeName]{
                    cvc.theme = theme
                }
                navigationController?.pushViewController(cvc, animated: true)
            }
            else{
                performSegue(withIdentifier: "ChooseTheme", sender: sender)
            }
        }
    }
    
    //在途中更换theme
    private var splitViewDetailConcentrationViewController: ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController:ConcentrationViewController? // 解决在iPhone中点theme还是会产生新的游戏
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChooseTheme"{
                if let themeName =  (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                    if let cvc = segue.destination as? ConcentrationViewController{
                        cvc.theme = theme
                        lastSeguedToConcentrationViewController = cvc
                    }
            }
        }
    }
    

}
