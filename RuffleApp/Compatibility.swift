import SwiftUI
import WebKit
import Network

final class LocalServer {
    private var listener: NWListener?
    private let queue = DispatchQueue(label:"canyon.loopback")
    private let root: URL
    init() { root = Bundle.main.resourceURL!.appendingPathComponent("Web") }
    func start(_ ready: @escaping (UInt16)->Void) throws {
        let parameters = NWParameters.tcp
        parameters.requiredLocalEndpoint = .hostPort(host:"127.0.0.1",port:.any)
        let l = try NWListener(using:parameters); listener = l
        l.stateUpdateHandler = { state in if case .ready = state, let port=l.port { DispatchQueue.main.async { ready(port.rawValue) } } }
        l.newConnectionHandler = { [root] c in
            c.start(queue:DispatchQueue.global(qos:.userInitiated))
            c.receive(minimumIncompleteLength:1,maximumLength:8192) { data,_,_,_ in
                guard let data=data, let req=String(data:data,encoding:.utf8) else { c.cancel(); return }
                let path = req.split(separator:" ").dropFirst().first.map(String.init) ?? "/"
                let name = path.split(separator:"?").first.map(String.init) ?? "/"
                let file = name == "/" ? "index.html" : String(name.dropFirst())
                guard !file.contains("/"), !file.contains(".."), let bytes=try? Data(contentsOf:root.appendingPathComponent(file)) else { c.send(content:Data("HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\nConnection: close\r\n\r\n".utf8),completion:.contentProcessed({_ in c.cancel()})); return }
                let mime = file.hasSuffix(".wasm") ? "application/wasm" : file.hasSuffix(".js") ? "text/javascript" : file.hasSuffix(".html") ? "text/html" : "application/octet-stream"
                let h = "HTTP/1.1 200 OK\r\nContent-Type: \(mime)\r\nContent-Length: \(bytes.count)\r\nCache-Control: no-store\r\nConnection: close\r\n\r\n"
                var response=Data(h.utf8); response.append(bytes); c.send(content:response,completion:.contentProcessed({_ in c.cancel()}))
            }
        }; l.start(queue:queue)
    }
}
@main struct CanyonCompatibility: App { var body: some Scene { WindowGroup { ContentView() } } }
struct ContentView: View {
    @State private var url: URL?; @State private var error: String?; private let server=LocalServer()
    var body: some View { ZStack { Color.black.ignoresSafeArea(); if let url { Player(url:url).ignoresSafeArea() } else if let error { Text(error).foregroundStyle(.white) } else { ProgressView().tint(.white) } }.statusBarHidden().onAppear { do { try server.start { p in url=URL(string:"http://127.0.0.1:\(p)/") } } catch { self.error=error.localizedDescription } } }
}
struct Player: UIViewRepresentable {
    let url: URL
    func makeCoordinator() -> Coordinator { Coordinator() }
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.mediaTypesRequiringUserActionForPlayback = []
        let view = WKWebView(frame: .zero, configuration: config)
        view.isOpaque = false
        view.backgroundColor = .black
        view.scrollView.isScrollEnabled = false
        view.navigationDelegate = context.coordinator
        context.coordinator.attach(view)
        view.load(URLRequest(url: url))
        return view
    }
    func updateUIView(_ view: WKWebView, context: Context) {}
    static func dismantleUIView(_ view: WKWebView, coordinator: Coordinator) { coordinator.detach() }

    final class Coordinator: NSObject, WKNavigationDelegate {
        private weak var view: WKWebView?
        private var observers: [NSObjectProtocol] = []
        private var active = UIApplication.shared.applicationState == .active
        func attach(_ view: WKWebView) {
            self.view = view
            let center = NotificationCenter.default
            observers.append(center.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { [weak self] _ in self?.setActive(false) })
            observers.append(center.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in self?.setActive(true) })
        }
        func detach() { observers.forEach { NotificationCenter.default.removeObserver($0) }; observers.removeAll(); view = nil }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if !active { webView.evaluateJavaScript("window.canyonSetActive && window.canyonSetActive(false)", completionHandler: nil); webView.setAllMediaPlaybackSuspended(true, completionHandler: nil) }
        }
        private func setActive(_ value: Bool) {
            guard active != value else { return }
            active = value
            guard let view else { return }
            if value {
                view.setAllMediaPlaybackSuspended(false) { [weak self, weak view] in
                    guard self?.active == true, let view else { return }
                    view.evaluateJavaScript("window.canyonSetActive && window.canyonSetActive(true)", completionHandler: nil)
                }
            } else {
                view.evaluateJavaScript("window.canyonSetActive && window.canyonSetActive(false)", completionHandler: nil)
                view.setAllMediaPlaybackSuspended(true, completionHandler: nil)
            }
        }
    }
}
