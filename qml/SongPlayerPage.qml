import QtQuick 2.0
import VPlayApps 1.0
import QtMultimedia 5.8
import QtQuick.Controls 1.2

import QtGraphicalEffects 1.0
import "AppLogic.js" as LOGIC

Page
{
    id: songplayerpage
    property real sliderValue: 0.0
    property bool startAnimation: false
    title: "Now Playing"
    Rectangle
    {
        id: playerimageRect
        color: "#212121"
        anchors.fill: parent
        Image
        {
            id: bgimage
            anchors.fill: parent
            source: coverArt
            smooth: true
            asynchronous: true
            visible: false
            onSourceChanged:
            {
                if(coverArt !== defaultCoverArt)
                    bluranime.start()
                else
                    bgimgblur.radius = 0
            }
        }
        FastBlur
        {
            id: bgimgblur
            anchors.fill: bgimage
            source: bgimage
            radius: 0
            NumberAnimation
            {
                id: bluranime
                target: bgimgblur
                property: "radius"
                from: 0
                to: 64
                duration: 500
            }
        }

        Rectangle
        {
            id: mainCvrArtRect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: sidebar.top
            anchors.bottomMargin: 5
            width: playerimageRect.width-30
            height: width
            visible: true
            color: "transparent"
            smooth: true
            MouseArea
            {
                property real xCord: 0.0
                property real distance: 0.0
                anchors.fill: parent
                onPressed: { xCord = mouseX }
                onPositionChanged: { distance = xCord - mouseX }
                onReleased:
                {
                    if(distance < 0 && distance <= -mainCvrArtRect.width/3)
                        LOGIC.playNextTrack()
                    if(distance > 0 && distance >= mainCvrArtRect.width/3)
                        LOGIC.playPrevTrack()
                }
            }
            AppImage
            {
                id: mainbgimage
                anchors.fill: parent
                asynchronous: true
                smooth: true
                source: coverArt
                visible: ifCoverArt
                Behavior on source
                {
                    NumberAnimation
                    {
                        target: mainbgimage
                        property: "scale"
                        from: 0.0
                        to: 1.0
                        duration: 500
                        onRunningChanged:
                        {
                            if(running)
                                console.log("running")
                            else
                                textanime.start()//console.log("not running")
                        }
                    }
                }
            }
        }
        Rectangle
        {
            property string temptext: currentPlayingArtist
            id: songtextRect
            width: parent.width/2+10
            anchors.top: parent.top
            anchors.bottom: mainCvrArtRect.top
            opacity: 0.0
            border.color: "white"
            color: "transparent"
            NumberAnimation
            {
                id: textanime
                target: songtextRect
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 800
            }

            AppText
            {
                id: songnameText
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                text: currentSongName
            }
            AppText
            {
                id: artistnameText
                anchors.top: songnameText.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                font.pixelSize: songnameText.font.pixelSize/1.4
                anchors.horizontalCenter: parent.horizontalCenter
                text: currentPlayingArtist
            }
            onTemptextChanged: opacity = 0.0
        }

        SideBar
        {
            id: sidebar
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: (parent.height - height)-(playercontrolar.height+10)
        }
    }
    Rectangle
    {
        id: playercontrolar
        width: parent.width
        height: parent.height/5+10
        anchors.bottom: parent.bottom
        //opacity: 0.8
        color: "transparent"
        //layer.enabled: true

        Rectangle
        {
            id: playerprogress
            width: parent.width
            height: parent.height/5 + 10
            color: Qt.rgba(0,0,0, 0.75)

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
                        duration: 800
                    }
                    NumberAnimation
                    {
                        target: remtime
                        property: "opacity"
                        to: 1.0
                        duration: 800
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
                knobColor: "#E91E63"
                tintedTrackColor: "#E91E63"
                trackColor: Qt.rgba(0,0,0, 0.75)
                onMoved: LOGIC.setSongPosition(position)
            }
        }
        Rectangle
        {
            id: control
            width: parent.width
            anchors.top: playerprogress.bottom
            anchors.bottom: parent.bottom
            color: Qt.rgba(0,0,0, 0.75)//"#212121"
            Row
            {
                id: controlRow
                anchors.centerIn: control
                spacing: dp(30)
                Rectangle
                {
                    width: prevbtn.width-5
                    height: prevbtn.height-5
                    border.color: "#E91E63"
                    radius: 50
                    color: Qt.rgba(0,0,0, 0.75)//"#212121"
                    IconButton
                    {
                        id: prevbtn
                        icon: IconType.backward
                        anchors.centerIn: parent
                        color: "white"
                        onClicked: LOGIC.playPrevTrack()
                    }
                }
                Rectangle
                {
                    width: playpausebtn.width + 15
                    height: playpausebtn.height + 15
                    border.color: "#E91E63"
                    color: Qt.rgba(0.21,0,0, 0.75)//"#212121"
                    radius: 50
                    IconButton
                    {
                        id: playpausebtn
                        anchors.centerIn: parent
                        icon: pIcon
                        color: "white"
                        onClicked: {LOGIC.playOrPause(); btnanime.start()}
                        NumberAnimation
                        {
                            id: btnanime
                            target: playpausebtn
                            property: "scale"
                            from: 0.0
                            to: 1.0
                            duration: 200
                        }
                    }
                }
                Rectangle
                {
                    width: nextbtn.width-5
                    height: nextbtn.height-5
                    border.color: "#E91E63"
                    color: Qt.rgba(0,0,0, 0.75)//"#212121"
                    radius: 50
                    IconButton
                    {
                        id: nextbtn
                        icon: IconType.forward
                        anchors.centerIn: parent
                        color: "white"
                        onClicked: LOGIC.playNextTrack()
                    }
                }
            }
        }
    }
}
