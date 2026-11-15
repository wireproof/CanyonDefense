import SwiftUI

@main struct CanyonDefenseApp: App {
    var body: some Scene { WindowGroup { Battlefield() } }
}

struct Enemy: Identifiable { let id = UUID(); var progress: CGFloat = 0; var health: CGFloat = 100 }
struct Tower: Identifiable { let id = UUID(); let x: CGFloat; let y: CGFloat; var cooldown: Int = 0 }

@MainActor final class Game: ObservableObject {
    @Published var enemies: [Enemy] = []
    @Published var towers: [Tower] = []
    @Published var money = 350
    @Published var lives = 10
    @Published var wave = 0
    @Published var remaining = 0
    @Published var running = false
    @Published var message = "Tap a rocky ledge to build a turret ($100)."
    let route: [CGPoint] = [CGPoint(x: -0.03,y: 0.16), CGPoint(x: 0.84,y: 0.16), CGPoint(x: 0.84,y: 0.48), CGPoint(x: 0.10,y: 0.48), CGPoint(x: 0.10,y: 0.82), CGPoint(x: 1.03,y: 0.82)]
    var tickCount = 0
    func point(_ p: CGFloat) -> CGPoint {
        let v = max(0, min(p, CGFloat(route.count - 1) - 0.0001)); let i = Int(v); let t = v - CGFloat(i)
        return CGPoint(x: route[i].x + (route[i+1].x-route[i].x)*t, y: route[i].y + (route[i+1].y-route[i].y)*t)
    }
    func place(_ p: CGPoint) {
        guard money >= 100, lives > 0 else { message = "Not enough funds, or game over."; return }
        let rocks = [".#############","............##",".............#",".............#",".#########...#","##......##...#","#............#","#............#","#...##......##","#...#########.","#.............","#.............","##............","#############."]
        let col = Int(p.x * 14), row = Int(p.y * 14)
        guard row >= 0, row < 14, col >= 0, col < 14 else { return }
        let line = Array(rocks[row]); let center = CGPoint(x:(CGFloat(col)+0.5)/14,y:(CGFloat(row)+0.5)/14)
        guard line[col] == "#", !towers.contains(where: { hypot($0.x-center.x,$0.y-center.y) < 0.06 }) else { message = "Choose an empty rocky ledge."; return }
        towers.append(Tower(x:center.x,y:center.y)); money -= 100; message = "Turret ready. Start the wave!"
    }
    func start() { guard !running, lives > 0 else { return }; wave += 1; remaining = min(4 + wave*2, 30); running = true; message = "Wave \(wave) incoming!" }
    func reset() { enemies=[]; towers=[]; money=350; lives=10; wave=0; remaining=0; running=false; message="Tap a rocky ledge to build a turret ($100)." }
    func tick() {
        guard running else { return }; tickCount += 1
        if remaining > 0 && tickCount % 18 == 0 { enemies.append(Enemy()); remaining -= 1 }
        for i in enemies.indices { enemies[i].progress += 0.006 }
        for i in towers.indices {
            if towers[i].cooldown > 0 { towers[i].cooldown -= 1; continue }
            if let j = enemies.indices.filter({ enemies[$0].health > 0 && hypot(point(enemies[$0].progress).x-towers[i].x,point(enemies[$0].progress).y-towers[i].y) < 0.20 }).max(by: { enemies[$0].progress < enemies[$1].progress }) {
                enemies[j].health -= 28; towers[i].cooldown = 12
            }
        }
        let killed = enemies.filter { $0.health <= 0 }.count
        let escaped = enemies.filter { $0.health > 0 && $0.progress >= CGFloat(route.count-1)-0.001 }.count
        money += killed * 20; lives = max(0, lives-escaped)
        enemies.removeAll { $0.health <= 0 || $0.progress >= CGFloat(route.count-1)-0.001 }
        if lives == 0 { running=false; message="Game over. Tap Reset to try again." }
        else if remaining == 0 && enemies.isEmpty { running=false; message="Wave cleared. Build more turrets or start the next wave." }
    }
}

struct Battlefield: View {
    @StateObject private var game = Game()
    let timer = Timer.publish(every: 1.0/24, on: .main, in: .common).autoconnect()
    var body: some View {
        GeometryReader { geo in
            let wide = geo.size.width > geo.size.height * 1.15
            ZStack {
                Image("Terrain").resizable().scaledToFill().frame(width:geo.size.width,height:geo.size.height).clipped().ignoresSafeArea()
                Color.black.opacity(0.28).ignoresSafeArea()
                if wide {
                    HStack(spacing: 8) { board; panel.frame(width: min(max(geo.size.width * 0.23, 150), 230)) }.padding(8)
                } else {
                    VStack(spacing: 8) { header; board; controls }.padding(8)
                }
            }.onReceive(timer) { _ in game.tick() }.statusBarHidden()
        }
    }
    var board: some View {
        GeometryReader { g in
            let side = min(g.size.width, g.size.height)
            ZStack {
                Image("MapSand").resizable().interpolation(.high)
                Image("MapRock").resizable().interpolation(.high)
                Canvas { ctx, size in
                    for t in game.towers {
                        let r = size.width * 0.047
                        ctx.draw(Image("Tower"), in: CGRect(x:t.x*size.width-r,y:t.y*size.height-r,width:r*2,height:r*2))
                    }
                    for e in game.enemies {
                        let p=game.point(e.progress), r=size.width*0.025
                        ctx.draw(Image("Enemy"), in:CGRect(x:p.x*size.width-r,y:p.y*size.height-r,width:r*2,height:r*2))
                        let hp=CGRect(x:p.x*size.width-r,y:p.y*size.height-r-4,width:r*2*e.health/100,height:2)
                        ctx.fill(Path(hp),with:.color(.green))
                    }
                }
            }.frame(width:side,height:side).clipped().overlay(Rectangle().stroke(Color(red:0.73,green:0.64,blue:0.45),lineWidth:2)).shadow(color:.black.opacity(0.7),radius:10)
            .contentShape(Rectangle()).gesture(SpatialTapGesture().onEnded { v in game.place(CGPoint(x:v.location.x/side,y:v.location.y/side)) })
            .position(x:g.size.width/2,y:g.size.height/2)
        }.frame(maxWidth:.infinity,maxHeight:.infinity)
    }
    var header: some View {
        HStack { Label("\(game.lives)",systemImage:"heart.fill"); Spacer(); Text("WAVE \(game.wave)"); Spacer(); Text("$\(game.money)") }
            .font(.system(.headline,design:.rounded).weight(.black).monospacedDigit()).foregroundStyle(.white)
            .padding(.horizontal,14).padding(.vertical,10).background(panelBackground)
    }
    var controls: some View {
        VStack(spacing:8) {
            Text(game.message).font(.caption.weight(.semibold)).foregroundStyle(Color.white.opacity(0.85)).frame(maxWidth:.infinity,alignment:.leading).lineLimit(2)
            HStack(spacing:10) { Button("RESET") { game.reset() }.buttonStyle(ControlStyle(color:.gray)); Spacer(); Label("TURRET  $100",systemImage:"scope").font(.caption.bold()).foregroundStyle(.white); Spacer(); Button(game.running ? "IN PROGRESS" : "START WAVE") { game.start() }.buttonStyle(ControlStyle(color:.orange)).disabled(game.running || game.lives == 0) }
        }.padding(10).background(panelBackground)
    }
    var panel: some View {
        VStack(spacing:12) {
            Text("CANYON").font(.system(size:21,weight:.black,design:.rounded)); Text("DEFENSE").font(.system(size:19,weight:.black,design:.rounded)).foregroundStyle(.orange)
            Rectangle().fill(.white.opacity(0.25)).frame(height:1)
            VStack(alignment:.leading,spacing:12) {
                Label("\(game.lives)  LIVES",systemImage:"heart.fill").foregroundStyle(.red)
                Label("\(game.wave)  WAVE",systemImage:"flag.fill").foregroundStyle(.white)
                Label("$\(game.money)",systemImage:"dollarsign.circle.fill").foregroundStyle(.yellow)
            }.font(.system(.headline,design:.rounded).weight(.bold).monospacedDigit()).frame(maxWidth:.infinity,alignment:.leading)
            Rectangle().fill(.white.opacity(0.25)).frame(height:1)
            Image("Tower").resizable().interpolation(.high).frame(width:52,height:52)
            Text("TURRET   $100").font(.caption.bold())
            Text(game.message).font(.caption).foregroundStyle(.white.opacity(0.8)).frame(maxWidth:.infinity,alignment:.leading)
            Spacer(minLength:0)
            Button(game.running ? "WAVE IN PROGRESS" : "START WAVE") { game.start() }.buttonStyle(ControlStyle(color:.orange)).disabled(game.running || game.lives == 0)
            Button("RESET MISSION") { game.reset() }.buttonStyle(ControlStyle(color:.gray))
        }.foregroundStyle(.white).padding(12).frame(maxWidth:.infinity,maxHeight:.infinity).background(panelBackground)
    }
    var panelBackground: some View { RoundedRectangle(cornerRadius:10).fill(Color(red:0.12,green:0.13,blue:0.13).opacity(0.94)).overlay(RoundedRectangle(cornerRadius:10).stroke(Color(red:0.61,green:0.54,blue:0.40),lineWidth:1)) }
}
struct ControlStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.system(size:12,weight:.black,design:.rounded)).foregroundStyle(.white).frame(minHeight:40).frame(maxWidth:.infinity).padding(.horizontal,8).background(color.opacity(configuration.isPressed ? 0.55 : 0.83),in:RoundedRectangle(cornerRadius:6)).overlay(RoundedRectangle(cornerRadius:6).stroke(.white.opacity(0.25),lineWidth:1))
    }
}
