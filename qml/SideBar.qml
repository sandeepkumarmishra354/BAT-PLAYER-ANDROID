import QtQuick 2.0
import VPlayApps 1.0
import "AppLogic.js" as LOGIC

Rectangle
{
    id: sidebar
    property int icnHeight: 0
    property int icnWidth: 0
    property bool shuffleOn: (mainplaylist.playbackMode === randomMode ? true : false)
    property bool repeatAllOn: (mainplaylist.playbackMode === repeatAllMode ? true : false)
    property bool repeatOneOn: (mainplaylist.playbackMode === repeatCurrentMode ? true : false)
    property bool timerOn: false
    property bool repeatOff: {
                                if(shuffleOn || mainplaylist.playbackMode === sequentialMode)
                                    return true
                                else
                                    return false
                             }
    width: 1
    height: icnHeight
    opacity: 0.7
    gradient: Gradient {
        GradientStop {position: 0.0; color: "#E91E63"}
        GradientStop {position: 1.0; color: "red"}
    }
    Behavior on width
    {
        NumberAnimation
        {
            easing.type: Easing.InOutElastic
            duration: 600
        }
    }
    Row
    {
        anchors.fill: parent
        IconButton
        {
            id: shuffle
            icon: IconType.random
            color: (shuffleOn ? "black" : "grey")
            Component.onCompleted: {icnHeight = height; icnWidth += width}
            onClicked: LOGIC.setRepeatShuffle("shuffle")
        }
        IconButton
        {
            id: repeat
            icon: IconType.repeat
            color: ( (repeatAllOn || repeatOneOn) ? "black" : "grey" )
            Component.onCompleted: {icnWidth += width}
            onClicked:
            {
                LOGIC.setRepeatShuffle("repeat")
                if(repeatAllOn)
                    icon = IconType.refresh
                if(repeatOneOn || repeatOff)
                    icon = IconType.repeat
            }
        }
        IconButton
        {
            id: timer
            icon: IconType.clocko
            color: (timerOn ? "black" : "grey")
            Component.onCompleted: {icnWidth += width}
            onClicked: {timermenu.open()}
        }
        NumberAnimation
        {
            id: srtanimeUp
            targets: [shuffle,repeat,timer]
            property: "scale"
            from: (sidebar.width <= 1 ? 0.0 : 1.0)
            to: (sidebar.width <= 1 ? 1.0 : 0.0)
            duration: 900
        }
    }

    Rectangle
    {
        id: sidebarClick
        width: icnHeight
        height: sidebar.height
        anchors.right: sidebar.left
        radius: 10
        color: "transparent"//"#212121"

        IconButton
        {
            anchors.fill: parent
            //icon: IconType.arrowsh
            icon: IconType.arrowcircleoleft
            color: "#E91E63"
            RotationAnimation on rotation
            {
                id: rotateBtn
                from: 0
                to: 360
                duration: 800
            }

            onClicked:
            {
                if(sidebar.width <= 1)
                {
                    sidebar.width = icnWidth
                    icon = IconType.arrowcircleoright
                }
                else
                {
                    sidebar.width = 1
                    icon = IconType.arrowcircleoleft
                }
                srtanimeUp.start()
                rotateBtn.start()
            }
        }
        Timer
        {
            interval: 7000  // 7 seconds
            running: true
            repeat: true
            onTriggered:
            {
                if(sidebar.width <= 1)
                    rotateBtn.start()
            }
        }
    }
}
