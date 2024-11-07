import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
// import QtWebView 1.1
// import QtWebEngine 1.7

Rectangle {
    id: categoryPage
    width: parent.width
    height: parent.height - 10
    property string theme: "light"
    color: themeObject.backgroundColor

    property string clientId: "1052979857026-6f80p32trf5iulemi0493d8cpv5dancp.apps.googleusercontent.com"
    property string redirectUri: "urn:ietf:wg:oauth:2.0:oob"
    property string authorizationUrl: "https://accounts.google.com/o/oauth2/v2/auth"

    // WebEngineView {
    //     id: webView
    //     anchors.fill: parent

    //     // Step 1: Open Google's OAuth 2.0 login page
    //     onUrlChanged: {
    //         // Step 2: Detect redirect after successful login and extract authorization code
    //         if (webView.url.indexOf(redirectUri) !== -1) {
    //             var url = webView.url;
    //             var authorizationCode = url.split("code=")[1];
    //             if (authorizationCode) {
    //                 console.log("Authorization Code: " + authorizationCode);

    //                 // Step 3: Exchange authorization code for access token (via REST API call)
    //                 getAccessToken(authorizationCode);
    //             }
    //         }
    //     }

    //     // Step 1: Load the Google login page with OAuth parameters
    //     Component.onCompleted: {
    //         var url = authorizationUrl +
    //             "?client_id=" + clientId +
    //             "&redirect_uri=" + redirectUri +
    //             "&response_type=code" +
    //             "&scope=https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email";
    //         webView.url = url;
    //     }
    // }

    Button {
        text: "Exit"
        width: 100
        height: 30
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        onClicked: {
            stackView.push(welcomePage)
        }

        background: Rectangle {
            id: button
            radius: 10
            border.width: 1
            border.color: themeObject.buttonBorderColor
        }
    }

    // Function to exchange authorization code for access token
    function getAccessToken(authCode) {
        var xhr = new XMLHttpRequest();
        var tokenUrl = "https://oauth2.googleapis.com/token";
        var params = "code=" + authCode +
                     "&client_id=" + clientId +
                     "&client_secret=YOUR_CLIENT_SECRET" +
                     "&redirect_uri=" + redirectUri +
                     "&grant_type=authorization_code";

        xhr.open("POST", tokenUrl, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                console.log("Access Token: " + response.access_token);
                getUserInfo(response.access_token);
            }
        };
        xhr.send(params);
    }

    // Function to get user information using the access token
    function getUserInfo(accessToken) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + accessToken, true);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                var userInfo = JSON.parse(xhr.responseText);
                console.log("User Info: " + JSON.stringify(userInfo));
            }
        };
        xhr.send();
    }
}