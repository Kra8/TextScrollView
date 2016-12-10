//
//  TextAnimationView.swift
//  TFreport
//
//  Created by K.Asai on 2016/12/10.
//  Copyright © 2016年 teA.AsaiKoki. All rights reserved.
//

import UIKit

public class TextSclollView: UIView {
    
    /// 実際にアニメーションを行うラベル
    fileprivate let animationTextLabel  = UILabel()
    fileprivate let animationScrollView = UIScrollView()
    
    private var duration : TimeInterval = 2.0
            
    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.animationTextLabel)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.white
        self.addSubview(self.animationTextLabel)
    }
    
    convenience public init() {
        self.init(frame: CGRect())
    }
    
    convenience public init(animationText: String) {
        self.init()
        self.animationTextLabel.text = animationText
    }
    
    
    //MARK: - Methods
    override public func layoutSubviews() {
        super.layoutSubviews()

        let orgH : CGFloat = self.frame.size.height
        
        // - アニメーションテキストの構成
        // 横幅をテキストに合わせる
        self.animationTextLabel.sizeToFit()
        
        // 高さをviewと同じに
        self.animationTextLabel.frame.size.height = orgH
        
        // - animation setup
        self.animationTextLabel.frame.origin.x = self.frame.width
    }
    
    ///
    /// アニメーションを開始する
    ///
    public func start() {
        // アニメーション開始位置
        self.animationTextLabel.frame.origin.x = self.frame.width
        UIView.animate(
            withDuration: self.duration,
            delay: 0.2,
            options: .curveLinear,
            animations: { _ in
                self.animationTextLabel.frame.origin.x = -self.animationTextLabel.frame.width
            },
            completion: { animated in
                self.animationTextLabel.frame.origin.x = -self.animationTextLabel.frame.width
                self.start()
            }
        )
    }
    
    ///
    /// アニメーションを一時停止する
    ///
    public func pouse() {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    ///
    /// アニメーションを再開する
    ///
    public func resume() {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    ///
    /// アニメーションするテキストを設定する
    ///
    /// - parameter text :
    ///
    public func setAnimationText(_ text: String) {
        self.animationTextLabel.text = text
    }
    
    ///
    /// アニメーションするテキストの背景を設定
    ///
    /// - parameter color :
    ///
    public func setAnimationBackgroundColor(_ color: UIColor) {
        self.animationTextLabel.backgroundColor = color
    }
    
    ///
    /// アニメーションするテキストのフォントを設定する
    ///
    /// - parameter font :
    ///
    public func setFont(_ font: UIFont) {
        self.animationTextLabel.font = font
    }
    
    ///
    /// アニメーションするテキストのカラーを設定する
    ///
    /// - parameter color :
    ///
    public func setColor(_ color: UIColor) {
        self.animationTextLabel.textColor = color
    }
    
    ///
    /// アニメーション間隔の時間を設定する
    /// 
    /// - parameter duration :
    ///
    public func setDuration(_ duration: TimeInterval) {
        self.duration = duration
    }
}
