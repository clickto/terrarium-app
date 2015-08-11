import QtQuick 2.0
import HttpServer 1.0

HttpServer {
    id: server
    Component.onCompleted: listen(platformIP, 5000)
    onNewRequest: {
        var route = /^\/\?/;
        if (request.url.toString().match(/\/update\?/)) {
            editor.text = decodeURI(request.url.toString().replace(/\/update\?/, "")).replace(/%23/g, '#');
            console.log(editor.text)
            response.writeHead(200)
            response.end()
            reloadView();
        }
        else if ( route.test(request.url) ) {
            response.writeHead(200)
            response.write(editor.text)
            response.end()
        }
        else {
            response.writeHead(404)
            response.end()
        }
    }
}
