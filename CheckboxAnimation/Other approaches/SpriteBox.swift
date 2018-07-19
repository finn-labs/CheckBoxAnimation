//
//  SpriteBox.swift
//  CheckboxAnimation
//
//  Created by Granheim Brustad , Henrik on 19/07/2018.
//  Copyright © 2018 Granheim Brustad , Henrik. All rights reserved.
//

import UIKit
import SpriteKit

class SpriteBox: SKView {
    
    private let atlas: SKTextureAtlas
    private var textures: [SKTexture]
    private var action: SKAction!
    var isAnimating = false
    
    private lazy var spriteNode: SKSpriteNode = {
        let node = SKSpriteNode()
        node.anchorPoint = CGPoint(x: 0, y: 0)
        return node
    }()
    
    override init(frame: CGRect) {
        atlas = SKTextureAtlas(named: "checkbox-selected")
        textures = [SKTexture]()
        for name in atlas.textureNames.sorted() {
            textures.append(atlas.textureNamed(name))
        }
        super.init(frame: frame)
        
        let scene = SKScene(size: frame.size)
        scene.backgroundColor = .white
        spriteNode.size = frame.size
        spriteNode.texture = textures.first
        scene.addChild(spriteNode)
        presentScene(scene)
    }
    
    func animate(reverse value: Bool) {
        action = .animate(with: textures, timePerFrame: 1.0 / 60.0)
        spriteNode.run(action) {
            self.isAnimating = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
