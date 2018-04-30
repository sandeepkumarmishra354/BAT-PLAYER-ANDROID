import QtQuick 2.0
import VPlayApps 1.0
import QtMultimedia 5.8
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0
import "JS/AppLogic.js" as LOGIC

Page
{
    property real sliderValue: 0.0
    property bool startAnimation: false
    id: songplayerpage
    title: "Now Playing"
    AppImage
    {
        id: playingbgImage
        anchors.fill: parent
        source: propertycontainer.coverArt
        Behavior on source
        {
            NumberAnimation
            {
                target: playingbgImage
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 1000
            }
        }
    }
    FastBlur
    {
        anchors.fill: playingbgImage
        source: playingbgImage
        radius: 50
        z: 1
    }

    Rectangle
    {
        id: playerimageRect
        gradient: propertycontainer.settingBgGradient
        anchors.fill: parent
        z: 2
        opacity: 0.6
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
                    if(distance < 0 && distance <= -mainCvrArtRect.width/3-10)
                        LOGIC.playPrevTrack()
                    if(distance > 0 && distance >= mainCvrArtRect.width/3-10)
                        LOGIC.playNextTrack()
                }
            }
            AppImage
            {
                id: mainbgimage
                anchors.fill: parent
                asynchronous: true
                smooth: true
                source: propertycontainer.coverArt
                visible: propertycontainer.ifCoverArt
                Behavior on source
                {
                    NumberAnimation
                    {
                        target: mainbgimage
                        property: "scale"
                        from: 0.0
                        to: 1.0
                        duration: 200
                        onRunningChanged:
                        {
                            if(running)
                                console.log("running")
                            else
                                textanime.start()
                        }
                    }
                }
            }
        }
        Rectangle
        {
            property string temptext: propertycontainer.currentPlayingArtist
            id: songtextRect
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: mainCvrArtRect.top
            opacity: 0.0
            color: "transparent"
            NumberAnimation
            {
                id: textanime
                target: songtextRect
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 300
            }

            AppText
            {
                id: songnameText
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                text: propertycontainer.currentSongName
            }
            AppText
            {
                id: artistnameText
                anchors.top: songnameText.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                font.pixelSize: songnameText.font.pixelSize/1.4
                anchors.horizontalCenter: parent.horizontalCenter
                text: propertycontainer.currentPlayingArtist
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
        z: 3
        width: parent.width
        height: parent.height/5+10
        anchors.bottom: parent.bottom
        color: propertycontainer.fullTransparent
        Rectangle
        {
            id: playerprogress
            width: parent.width
            height: parent.height/5 + 10
            color: propertycontainer.fullTransparent

            AppText
            {
                id: remtime
                text: propertycontainer.remTime
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
                text: propertycontainer.totalTime
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
                knobColor: propertycontainer.lightPink
                tintedTrackColor: propertycontainer.lightPink
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
            color: propertycontainer.fullTransparent
            Row
            {
                id: controlRow
                anchors.centerIn: control
                spacing: dp(30)
                Rectangle
                {
                    width: prevbtn.width
                    height: prevbtn.height
                    radius: 50
                    color: Qt.rgba(0,0,0, 0.75)
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
                    id: plbtnRect
                    width: playpausebtn.width + 15
                    height: playpausebtn.height + 15
                    color: "white"
                    radius: 50
                    IconButton
                    {
                        id: playpausebtn
                        anchors.centerIn: parent
                        icon: propertycontainer.pIcon
                        color: "black"
                        onClicked:
                        {
                            LOGIC.playOrPause()
                            btnanime1.start()
                            btnanime2.start()
                            btnanime3.start()
                        }
                        NumberAnimation
                        {
                            id: btnanime1
                            target: playpausebtn
                            property: "scale"
                            from: 0.0
                            to: 1.0
                            duration: 700
                        }
                        NumberAnimation
                        {
                            id: btnanime2
                            target: playpausebtn
                            property: "rotation"
                            from: 0
                            to: 360
                            duration: 700
                        }
                        NumberAnimation
                        {
                            id: btnanime3
                            target: plbtnRect
                            property: "width"
                            from: plbtnRect.width+10
                            to: plbtnRect.width
                            duration: 700
                        }
                    }
                }
                Rectangle
                {
                    width: nextbtn.width
                    height: nextbtn.height
                    color: Qt.rgba(0,0,0, 0.75)
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
