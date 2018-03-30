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
        height: parent.height - parent.height/5
        Rectangle
        {
            id: songsTab
            Image
            {
                id: mainbg
                anchors.fill: parent
                source: "../assets/main-bg.jpg"
            }
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
                    //console.log(path)
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
                backgroundColor: "#212121"
            }
        }
    }
    Rectangle
    {
        id: musicControl
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.top: songItemContainer.bottom
        Rectangle
        {
            id: songNameHolder
            width: (parent.width / 2) + (parent.width / 3)
            height: parent.height
            anchors.left: parent.left
            color: "#212121"

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
            color: "#212121"
            Rectangle
            {
                anchors.centerIn: parent
                width: playpausebtn.width
                height: playpausebtn.height
                border.color: "white"
                radius: 50
                color: "#212121"
                IconButton
                {
                    id: playpausebtn
                    icon: pIcon
                    color: "white"
                    anchors.fill: parent
                    onClicked: LOGIC.playOrPause()
                }
            }
        }
    }
}
