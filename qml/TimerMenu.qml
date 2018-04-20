import QtQuick 2.9
import QtQuick.Controls 2.3
import VPlayApps 1.0
import QtQuick.Controls.Material 2.1
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import "AppLogic.js" as LOGIC

Menu
{
    property int timerInterval
    id: mainTimerMenu
    opacity: 0.0
    Behavior on opacity {
        NumberAnimation{duration: 400}
    }
    background: Rectangle
    {
        id: bgRect
        radius: 30
        border.width: 1
        border.color: "#E91E63"
        color: Qt.rgba(0,0,0, 0.75)
        Rectangle
        {
            id: timerRect
            width: parent.width
            height: parent.height/2+25
            color:  "transparent"
            Rectangle
            {
                id: hrtumblerRect
                height: timerRect.height
                width: timerRect.width/2 - 5
                anchors.left: parent.left
                color:  "transparent"
                HourTumbler
                {
                    id: hrtumbler
                    anchors.fill: parent
                }
            }
            Rectangle
            {
                id: timerIndicator
                anchors.left: hrtumblerRect.right
                anchors.right: mintumblerRect.left
                anchors.bottom: hrtumblerRect.bottom
                height: 0
                gradient: Gradient
                {
                    GradientStop {position: 0.0; color: "#E91E63"}
                    GradientStop {position: 1.0; color: "red"}
                }

                NumberAnimation
                {
                    id: clranime
                    target: timerIndicator
                    property: "height"
                    from: 0
                    to: hrtumblerRect.height
                    duration: 20000
                }
                NumberAnimation
                {
                    id: clranimeStop
                    target: timerIndicator
                    property: "height"
                    from: timerIndicator.height
                    to: 0
                    duration: 800
                }
            }

            Rectangle
            {
                id: mintumblerRect
                height: timerRect.height
                width: timerRect.width/2 - 5
                anchors.right: parent.right
                color:  "transparent"
                MinuteTumbler
                {
                    id: mintumbler
                    anchors.fill: parent
                }
            }
        }

        Rectangle
        {
            id: btnRect
            width: parent.width
            anchors.top: timerRect.bottom
            anchors.bottom: parent.bottom
            color:  "transparent"
            AppText
            {
                id: hrminText
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#E91E63"
                text:
                {
                    var hr = hrtumbler.getCurrentIndex()
                    var mn = mintumbler.getCurrentIndex()
                    var txt = qsTr("Hr. %1 Min. %2").arg(hr).arg(mn)
                    return txt
                }
            }

            Row
            {
                anchors.centerIn: parent
                IconButton
                {
                    id: onoffbtn
                    icon: IconType.play
                    Behavior on opacity
                    {
                        NumberAnimation { duration: 500 }
                    }
                    Behavior on visible
                    {
                        NumberAnimation { duration: 500 }
                    }

                    onClicked: LOGIC.timerOnOffClicked()
                }
                IconButton
                {
                    id: stopbtn
                    icon: IconType.stop
                    color: "red"
                    onClicked: LOGIC.timerStopClicked()
                }
                IconButton
                {
                    id: restart
                    icon: IconType.repeat
                    onClicked:
                    {
                        quittimer.restart()
                        clranime.restart()
                    }
                }
            }
            Timer
            {
                id: quittimer
                interval: timerInterval
                onTriggered: { LOGIC.saveData(); Qt.quit() }
            }
        }
    }

    onOpened: { opacity = 1.0 }
    onClosed: { opacity = 0.0 }
}
