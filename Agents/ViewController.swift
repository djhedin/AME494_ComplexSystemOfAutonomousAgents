//
//  ViewController.swift

//

import Cocoa
import Tin


class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Agents"
        makeView(width: 1200.0, height: 800.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    
    var vehicles: [Vehicle] = []
    var env = Environment()
    
    
    override func setup() {
        for _ in 1...10 {
            let v = Vehicle(x: random(max: tin.width), y: random(max: tin.height))
            vehicles.append(v)
        }
    }
    
    
    override func update() {
        background(gray: 1.0)
        

        env.render()
        
        for v in vehicles {
            v.run(env: env)
        }
    }
    
    
}

