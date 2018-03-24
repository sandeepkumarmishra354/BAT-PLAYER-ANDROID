import QtQuick 2.0
import VPlayApps 1.0

Page
{
    id: root
    title: "About"
    backgroundColor: "#66ffff"
    readonly property string toEmail: "sandeepkumarmishra354@gmail.com"
    readonly property string toSubj: "BAT-PLAYER bug report"
    property string bugMsg: ""

    Image
    {
        id: appIcon
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/3
        height: width
        anchors.topMargin: 50
        source: "../assets/icons/Bat_player.png"
    }
    Rectangle
    {
        id: detailrect
        width: parent.width
        anchors.top: appIcon.bottom
        anchors.bottom: parent.bottom
        gradient: Gradient
                  {
                    GradientStop{position: 0.0; color: "#66ffff"}
                    GradientStop{position: 1.0; color: "#008080"}
                  }
        Column
        {
            id: descriptionColumn
            width: parent.width
            spacing: dp(10)
            //anchors.centerIn: parent
            AppText
            {
                id: appVersionText
                anchors.horizontalCenter: parent.horizontalCenter
                color: "blue"
                text: "<b><i>BAT-PLAYER version 1.0</i></b>"
            }
            AppText
            {
                id: modeText
                anchors.horizontalCenter: parent.horizontalCenter
                color: "blue"
                text: "<u><i>In developing/testing mode</i></u>"
            }
            AppText
            {
                id: author
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Author: <b><i>sandeep mishra</i><b>"
            }
            AppText
            {
                id: code
                anchors.horizontalCenter: parent.horizontalCenter
                text: "This App is written in Qt/QML/V-Play"
            }
            AppText
            {
                id: edupurpose
                anchors.horizontalCenter: parent.horizontalCenter
                text: "(for educational purpose only)"
                color: "blue"
            }
            AppText
            {
                id: note
                anchors.horizontalCenter: parent.horizontalCenter
                color: "red"
                text: "<b>Note:</b> place your music files"
            }
            AppText
            {
                id: notehalf
                anchors.horizontalCenter: parent.horizontalCenter
                color: "red"
                text: "to internal storage's Music folder"
            }

            AppText
            {
                id: source
                anchors.horizontalCenter: parent.horizontalCenter
                text: "There is no copyright or any other issue"
            }
            Row
            {
                id: sourcebugrow
                spacing: dp(5)
                anchors.horizontalCenter: parent.horizontalCenter
                AppButton
                {
                    id: gitAddress
                    text: "Source"
                    icon: IconType.code
                    backgroundColor: "#19194d"
                    onClicked: nativeUtils.openUrl("https://github.com/sandeepkumarmishra354/BAT-PLAYER-ANDROID")
                }
                AppButton
                {
                    id: bugbutton
                    text: "Report bug"
                    icon: IconType.bug
                    backgroundColor: "#ff3333"
                    onClicked: {nativeUtils.displayTextInput("Bug Report","Describe bug","","","Report","Cancel")}
                }
            }

            Connections
            {
                target: nativeUtils
                onTextInputFinished:
                {
                    if(accepted)
                    {
                        if(enteredText != "")
                        {
                            bugMsg = enteredText
                            nativeUtils.sendEmail(toEmail, toSubj, bugMsg)
                        }
                    }
                }
            }
        }
    }
}
