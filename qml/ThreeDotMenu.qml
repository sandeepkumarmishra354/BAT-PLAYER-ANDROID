import QtQuick 2.9
import QtQuick.Controls 2.2
import VPlayApps 1.0

Menu
{
    opacity: 0.0
    Behavior on opacity {
        NumberAnimation{duration: 300}
    }
    MenuItem
    {
        id: itmShuffle
        text: "shuffle on"
        checkable: true
        checked: shuffleOn
        width: parent.width
        background: Rectangle
        {
            color: "#212121"
            implicitHeight: dp(50)
        }
        contentItem: Text
        {
            elide: Text.ElideRight
            leftPadding: itmShuffle.indicator.width
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
            text: itmShuffle.text
        }
        indicator: Item
        {
            height: parent.height
            width: parent.width/4
            anchors.verticalCenter: parent.verticalCenter
            Rectangle
            {
                height: parent.height/2
                width: parent.width/2
                radius: 50
                border.color: "white"
                color: (shuffleOn ? "#E91E63" : "#212121")
                anchors.centerIn: parent
            }
        }
        onToggled:
        {
            if(checked)
                mainplaylist.playbackMode = randomMode
        }
    }
    MenuItem
    {
        id: itmRepeatOne
        text: "repeat one"
        checkable: true
        checked: repeatOne
        width: parent.width
        background: Rectangle{ color: "#212121"; implicitHeight: dp(50) }
        contentItem: Text
        {
            elide: Text.ElideRight
            leftPadding: itmRepeatOne.indicator.width
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
            text: itmRepeatOne.text
        }
        indicator: Item
        {
            height: parent.height
            width: parent.width/4
            anchors.verticalCenter: parent.verticalCenter
            Rectangle
            {
                height: parent.height/2
                width: parent.width/2
                radius: 50
                border.color: "white"
                color: (repeatOne ? "#E91E63" : "#212121")
                anchors.centerIn: parent
            }
        }
        onToggled:
        {
            if(checked)
                mainplaylist.playbackMode = repeatCurrentMode
        }
    }
    MenuItem
    {
        id: itmRepeatAll
        text: "repeat all"
        checkable: true
        checked: repeatAll
        width: parent.width
        background: Rectangle{ color: "#212121"; implicitHeight: dp(50) }
        contentItem: Text
        {
            elide: Text.ElideRight
            leftPadding: itmRepeatAll.indicator.width
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
            text: itmRepeatAll.text
        }
        indicator: Item
        {
            height: parent.height
            width: parent.width/4
            anchors.verticalCenter: parent.verticalCenter
            Rectangle
            {
                height: parent.height/2
                width: parent.width/2
                radius: 50
                border.color: "white"
                color: (repeatAll ? "#E91E63" : "#212121")
                anchors.centerIn: parent
            }
        }
        onToggled:
        {
            if(checked)
                mainplaylist.playbackMode = repeatAllMode
        }
    }
    MenuItem
    {
        id: itmOff
        text: "off"
        checkable: true
        checked: allOff
        width: parent.width
        background: Rectangle{ color: "#212121"; implicitHeight: dp(50) }
        contentItem: Text
        {
            elide: Text.ElideRight
            leftPadding: itmOff.indicator.width
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
            text: itmOff.text
        }
        indicator: Item
        {
            height: parent.height
            width: parent.width/4
            anchors.verticalCenter: parent.verticalCenter
            Rectangle
            {
                height: parent.height/2
                width: parent.width/2
                radius: 50
                border.color: "white"
                color: (allOff ? "#E91E63" : "#212121")
                anchors.centerIn: parent
            }
        }
        onToggled:
        {
            if(checked)
                mainplaylist.playbackMode = sequentialMode
        }
    }
    onOpened: { opacity = 1.0 }
    onClosed: { opacity = 0.0 }
} 
