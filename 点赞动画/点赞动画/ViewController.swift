//
//  ViewController.swift
//  点赞动画
//
//  Created by dfpo on 16/7/5.
//  Copyright © 2016年 dfpo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        likeAnimation()
    }
    
    func likeAnimation() {
        var tagNumber: Int = 500000
        tagNumber+=1
        
        let image = UIImage.init(named: randomImageName())
        let imageView = UIImageView.init(image: image)
        imageView.center = CGPointMake(-5000, -5000)
        imageView.tag = tagNumber
        view.addSubview(imageView)
        
        let group = groupAnimation()
        group.setValue(tagNumber, forKey: "animationName")
        imageView.layer.addAnimation(group, forKey: "wendingding")
    }
    func groupAnimation() -> CAAnimationGroup{
        
        let group = CAAnimationGroup.init()
        group.duration = 2.0;
        group.repeatCount = 1;
        let animation = scaleAnimation()
        let keyAnima = positionAnimatin()
        let alphaAnimation = alphaAnimatin()
        group.animations = [animation, keyAnima, alphaAnimation]
        group.delegate = self;
        return group
    }
    
    func scaleAnimation() -> CABasicAnimation {
        // 设定为缩放
        let animation = CABasicAnimation.init(keyPath: "transform.scale")
        // 动画选项设定
        animation.duration = 0.5// 动画持续时间
        //    animation.autoreverses = NO; // 动画结束时执行逆动画
        animation.removedOnCompletion = false
        
        // 缩放倍数
        animation.fromValue = 0.1 // 开始时的倍率
        animation.toValue = 1.0 // 结束时的倍率
        return animation
    }
    
    func positionAnimatin() -> CAKeyframeAnimation {
        
        let keyAnima=CAKeyframeAnimation.init()
        keyAnima.keyPath="position"
        
        //1.1告诉系统要执行什么动画
        //创建一条路径
        let path = CGPathCreateMutable()
        
        //设置一个圆的路径
        //    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
        
        CGPathMoveToPoint(path, nil, 200 , 200)
        let controlX = Int((arc4random() % (100 + 1))) - 50
        let controlY = Int((arc4random() % (130 + 1))) + 50
        let entX = Int((arc4random() % (100 + 1))) - 50
        
        CGPathAddQuadCurveToPoint(path, nil, CGFloat(200 - controlX), CGFloat(200 - controlY), CGFloat(200 + entX), 200 - 260)
        
        keyAnima.path=path;
        //有create就一定要有release, ARC自动管理
        //        CGPathRelease(path);
        //1.2设置动画执行完毕后，不删除动画
        keyAnima.removedOnCompletion = false
        //1.3设置保存动画的最新状态
        keyAnima.fillMode=kCAFillModeForwards
        //1.4设置动画执行的时间
        keyAnima.duration=2.0
        //1.5设置动画的节奏
        keyAnima.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        return keyAnima
    }
    
    func alphaAnimatin() -> CABasicAnimation {
    
        let alphaAnimation = CABasicAnimation.init(keyPath: "opacity")
        
        // 动画选项设定
        alphaAnimation.duration = 1.5 // 动画持续时间
        alphaAnimation.removedOnCompletion = false
        
        alphaAnimation.fromValue = 1.0
        alphaAnimation.toValue = 0.1
        alphaAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        alphaAnimation.beginTime = 0.5
        
        return alphaAnimation
    }
    func randomImageName() -> String {
        
        let number = Int(arc4random() % (4 + 1));
        var randomImageName: String
        switch (number) {
        case 1:
            randomImageName = "bHeart"
            break;
        case 2:
            randomImageName = "gHeart"
            break;
        case 3:
            randomImageName = "rHeart"
            break;
        case 4:
            randomImageName = "yHeart"
            break;
        default:
            randomImageName = "bHeart"
            break;
        }
        return randomImageName
    }

}

