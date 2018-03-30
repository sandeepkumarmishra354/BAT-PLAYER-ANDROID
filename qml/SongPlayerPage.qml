import QtQuick 2.0
import VPlayApps 1.0
import QtMultimedia 5.8
import "AppLogic.js" as LOGIC

Page
{
    id: songplayerpage
    property real sliderValue: 0.0
    property bool startAnimation: false
    property string shuffleColor: "#838D89"
    property string repeatColor: "#838D89"
    title: ""
    //navigationBarHidden: true

    rightBarItem: NavigationBarItem
    {
        IconButtonBarItem
        {
            icon: IconType.ellipsisv
            color: "blue"
            onClicked:
            {
                console.log("Android Action bar")
            }
        }
    }

    Rectangle
    {
        id: playerimageRect
        //width: parent.width
        //height: parent.height/2 + parent.height/3
        color: "#212121"
        anchors.fill: parent
        Image
        {
            id: bgimage
            anchors.fill: parent
            source: "../assets/music-bg.jpg"
        }

        BorderImage
        {
            id: songImage
            width: dp(200)
            height: dp(200)
            anchors.centerIn: parent
            opacity: 0.4
            source: "../assets/black-cd.png"
            smooth: true

            RotationAnimation on rotation
            {
                id: rotationId
                loops: Animation.Infinite
                from: 0
                to: 360
                running: startAnimation
                duration: 2000
            }
        }
    }
    Rectangle
    {
        id: playercontrolar
        width: parent.width
        height: parent.height/5+10
        //anchors.top: playerimageRect.bottom
        anchors.bottom: parent.bottom
        opacity: 0.8
        layer.enabled: true

        Rectangle
        {
            id: playerprogress
            width: parent.width
            height: parent.height/5 + 10
            color: "#212121"

            AppText
            {
                id: remtime
                text: remTime
                color: "white"
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                opacity: (startAnimation ? 1.0 : 0.0)

                SequentialAnimation
                {
                    running: !startAnimation
                    loops: Animation.Infinite
                    NumberAnimation
                    {
                        target: remtime
                        property: "opacity"
                        to: 0.0
                        duration: 700
                    }
                    NumberAnimation
                    {
                        target: remtime
                        property: "opacity"
                        to: 1.0
                        duration: 700
                    }
                }
            }
            AppText
            {
                id: totaltime
                text: totalTime
                color: "white"
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
            }

            AppSlider
            {
                id: songslider
                width: parent.width - (remtime.width+totaltime.width+25)
                anchors.centerIn: parent
                value: sliderValue
                smooth: true
                knobColor: "#005c99"
                tintedTrackColor: "#005c99"
                onMoved:
                {
                    LOGIC.setSongPosition(position)
                }
            }
        }
        Rectangle
        {
            id: control
            width: parent.width
            anchors.top: playerprogress.bottom
            anchors.bottom: parent.bottom
            color: "#212121"
            Row
            {
                id: controlRow
                anchors.centerIn: control
                spacing: dp(30)
                Rectangle
                {
                    width: prevbtn.width
                    height: prevbtn.height
                    border.color: "white"
                    radius: 50
                    color: "#212121"
                    IconButton
                    {
                        id: prevbtn
                        icon: IconType.backward
                        color: "white"
                        onClicked: LOGIC.playPrevTrack()
                    }
                }
                Rectangle
                {
                    width: playpausebtn.width
                    height: playpausebtn.height
                    border.color: "white"
                    color: "#212121"
                    radius: 50
                    IconButton
                    {
                        id: playpausebtn
                        icon: pIcon
                        color: "white"
                        onClicked: LOGIC.playOrPause()
                    }
                }
                Rectangle
                {
                    width: nextbtn.width
                    height: nextbtn.height
                    border.color: "white"
                    radius: 50
                    color: "#212121"
                    IconButton
                    {
                        id: nextbtn
                        icon: IconType.forward
                        color: "white"
                        onClicked: LOGIC.playNextTrack()
                    }
                }
            }
        }
    }
}
