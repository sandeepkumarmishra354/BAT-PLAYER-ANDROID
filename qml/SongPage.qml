import QtQuick 2.0
import QtQuick.Controls 2.2 as QQCONTROL
import VPlayApps 1.0
import QtMultimedia 5.8
import QtGraphicalEffects 1.0
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
            AppImage
            {
                id: mainbg
                anchors.fill: parent
                visible: propertycontainer.ifMainImageOn
                source: propertycontainer.mainBgImage
                Behavior on source {
                    NumberAnimation
                    {
                        target: mainbg
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: 1000
                    }
                }
            }
            Rectangle
            {
                anchors.fill: parent
                visible: !propertycontainer.ifMainImageOn
                gradient: propertycontainer.settingBgGradient
            }

            SearchBar
            {
                id: searchbar
                pullEnabled: true
                target: songlistview
                inputBackgroundColor: "#E6000000"
                barBackgroundColor: "#66000000"
                iconColor: propertycontainer.lightPink
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
            AppImage
            {
                id: playlistbg
                anchors.fill: parent
                source: propertycontainer.mainBgImage
                Behavior on source {
                    NumberAnimation
                    {
                        target: playlistbg
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: 1000
                    }
                }
            }
            AppListView
            {
                id: playlistView
                anchors.fill: parent
                model: playlistModel
                delegate: SimpleRow
                {
                    text: plOption
                    style.backgroundColor: Qt.rgba(0,0,0, 0.45)
                    style.dividerColor: propertycontainer.listDividerColor
                    style.detailTextColor: propertycontainer.detailTextColor
                    onSelected: LOGIC.openPlaylist(text)
                }
                emptyText.text: propertycontainer.noPlaylistText
                emptyText.color: "purple"
            }
        }
    }
    Rectangle
    {
        id: musicControl
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.top: songItemContainer.bottom
        onWidthChanged: propertycontainer.pageTotalWidth = width

        Rectangle
        {
            id: pageP
            anchors.top: parent.top
            width: propertycontainer.pageProgressWidth
            smooth: true
            antialiasing: true
            z: 1
            height: 1
            gradient: Gradient {
                GradientStop {position: 0.0; color: propertycontainer.lightPink}
                GradientStop {position: 1.0; color: "red"}
            }
        }
        Rectangle
        {
            id: songNameHolder
            width: (parent.width / 2) + (parent.width / 3)
            height: parent.height
            anchors.left: parent.left
            color: propertycontainer.darkColor

            AppText
            {
                id: songText
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 5
                fontSizeMode: Text.Fit
                text: propertycontainer.currentSongName
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
            color: propertycontainer.darkColor
            Rectangle
            {
                anchors.centerIn: parent
                width: playpausebtn.width
                height: playpausebtn.height
                color: propertycontainer.textColor
                radius: 50
                IconButton
                {
                    id: playpausebtn
                    icon: propertycontainer.pIcon
                    color: "black"
                    anchors.fill: parent
                    onClicked: {LOGIC.playOrPause(); btnanime1.start(); btnanime2.start()}
                    NumberAnimation
                    {
                        id: btnanime1
                        target: playpausebtn
                        property: "scale"
                        from: 0.0
                        to: 1.0
                        duration: 200
                    }
                    NumberAnimation
                    {
                        id: btnanime2
                        target: playpausebtn
                        property: "rotation"
                        from: 0
                        to: 360
                        duration: 200
                    }
                }
            }
        }
    }
}
