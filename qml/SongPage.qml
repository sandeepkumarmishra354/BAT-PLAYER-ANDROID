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
            tabIcon: IconType.music
        }
        AppTabButton
        {
            id: playlistTabOption
            text: "Playlist"
            tabIcon: IconType.playcircleo
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
            SearchBar
            {
                id: searchbar
                pullEnabled: true
                target: songlistview
                inputBackgroundColor: "#E6000000"
                barBackgroundColor: "#66000000"
                iconColor: "#E91E63"
                placeHolderText: "Search song"
                opacity: 0.0
                Behavior on opacity
                {
                    NumberAnimation{duration: 200}
                }
                onTextChanged: LOGIC.searchSong(text)
            }
            SongList
            {
                id: songlistview
                height: parent.height - y
                onSongIndex: LOGIC.playThis(index, row)
                onSongPath: {
                    mainplaylist.addItem(path)
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
                model: playlistModel
                delegate: SimpleRow
                {
                    text: plOption
                    style.backgroundColor: "#212121"
                    style.dividerColor: "#66000000"
                    style.textColor: "white"
                    onSelected: LOGIC.openPlaylist(text)
                }
                emptyText.text: noPlaylistText
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
            anchors.top: parent.top
            width: parent.width
            z: 1
            height: 1
            //color: "#E91E63"
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#E91E63"}
                GradientStop {position: 1.0; color: "red"}
            }
        }
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
                anchors.leftMargin: 5
                fontSizeMode: Text.Fit
                text: currentSongName
                color: "white"
                onTextChanged:
                {
                    if(width > parent.width)
                        console.log("large")
                    else
                        console.log("small")
                }
            }
            MouseArea
            {
                property real yCord: 0.0
                property real distance: 0.0
                anchors.fill: parent
                onClicked: navigationStack.push(playingpage)
                onPressed: yCord = mouseY
                onPositionChanged:
                {
                    distance = yCord - mouseY
                }
                onReleased:
                {
                    if(distance > 0 && distance >= height/2)
                        navigationStack.push(playingpage)
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
                border.color: "#E91E63"
                color: "#212121"
                radius: 50
                IconButton
                {
                    id: playpausebtn
                    icon: pIcon
                    color: "white"
                    anchors.fill: parent
                    onClicked: {LOGIC.playOrPause(); btnanime.start()}
                    NumberAnimation
                    {
                        id: btnanime
                        target: playpausebtn
                        property: "scale"
                        from: 0.0
                        to: 1.0
                        duration: 500
                    }
                }
            }
        }
    }
}
