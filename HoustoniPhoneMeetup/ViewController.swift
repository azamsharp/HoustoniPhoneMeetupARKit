//
//  ViewController.swift
//  HoustoniPhoneMeetup
//
//  Created by Mohammad Azam on 7/17/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private var planes = [Plane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        
        self.sceneView.autoenablesDefaultLighting = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        let burgerScene = SCNScene(named: "burgers.dae")!
//        let burgerNode = burgerScene.rootNode.childNode(withName: "burger", recursively: true)!
//        burgerNode.position = SCNVector3(0,0,-1)
//
//        // Create a new scene
        let scene = SCNScene()
//
//        scene.rootNode.addChildNode(burgerNode)
        
        
//        let circle = SCNSphere(radius: 0.3)
//
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "earth.jpg")
//
//        circle.firstMaterial = material
//
//        let circleNode = SCNNode(geometry: circle)
//        circleNode.position = SCNVector3(0,0,-0.5)
//
//        scene.rootNode.addChildNode(circleNode)
        
        
//        let cube = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
//
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "rusted-iron.png")
//
//        cube.materials = [material]
//
//        let cubeNode = SCNNode(geometry: cube)
//        cubeNode.position = SCNVector3(0,0,-0.5)
//
//        scene.rootNode.addChildNode(cubeNode)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if !(anchor is ARPlaneAnchor) {
            return
        }
        
        let plane = Plane(anchor: anchor as! ARPlaneAnchor)
        self.planes.append(plane)
        
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        let plane = self.planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
            }.first
        
        if plane == nil {
            return
        }
        
        plane?.update(anchor: anchor as! ARPlaneAnchor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}
