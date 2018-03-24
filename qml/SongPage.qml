import QtQuick 2.0
import QtQuick.Controls 2.2 as QQCONTROL
import VPlayApps 1.0
import QtMultimedia 5.8
import "AppLogic.js" as LOGIC

Page
{
    id: songPage
    title: "Library"

    AppTabBar
    {
        id: songTabBar
        showIcon: true
        contentContainer: songItemContainer
        AppTabButton
        {
            id: songTabOption
            text: "Songs"
        }
        AppTabButton
        {
            id: playlistTabOption
            text: "Playlist"
        }
    }
    QQCONTROL.SwipeView
    {
        id: songItemContainer
        clip: true
        anchors.top: songTabBar.bottom
        width: parent.width
        height: parent.height - parent.height/6
        Rectangle
        {
            id: songsTab
            SongList
            {
                id: songlistview
                onSongIndex:
                {
                    LOGIC.playThis(index, row)
                }
                onSongPath:
                {
                    mainplaylist.addItem(path)
                    totalSongs++
                }
            }
        }
        Rectangle
        {
            id: playlistTab
            AppListView
            {
                id: playlistView
                anchors.fill: parent
                model: []
                delegate: SimpleRow {}
                emptyText.text: "No Playlist"
            }
        }
    }
    Rectangle
    {
        id: musicControl
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.top: songItemContainer.bottom
        border.color: "lightblue"
        Rectangle
        {
            id: songNameHolder
            width: (parent.width / 2) + (parent.width / 3)
            height: parent.height
            anchors.left: parent.left
            gradient: Gradient {
                GradientStop {position: 1.0; color: "#00b3b3"}
                GradientStop {position: 0.0; color: "#008080"}
            }
            AppText
            {
                id: songText
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                fontSizeMode: Text.Fit
                text: currentSongName
                color: "white"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                     songsStack.push(playingpage)
                }
            }
        }

        Rectangle
        {
            id: controlHolder
            height: parent.height
            anchors.left: songNameHolder.right
            anchors.right: parent.right
            color: "#b3ffff"
            IconButton
            {
                id: playpausebtn
                anchors.fill: parent
                size: parent.width - 20
                icon: IconType.play
                color: "#00b3b3"
                onClicked:
                {
                    icon = (icon==IconType.play ? IconType.pause : IconType.play)
                    LOGIC.playOrPause()
                }
            }
        }
    }
}
