import QtQuick 2.9
import QtQuick.Controls 2.2
import VPlayApps 1.0
import "AppLogic.js" as LOGIC

Menu
{
    id: mainParent
    opacity: 0.0
    Behavior on opacity {
        NumberAnimation{duration: 400}
    }

    background: Rectangle
    {
        color: "#212121"
        AppListView
        {
            id: list
            anchors.fill: parent
            emptyText.text: "No playlist found, Tap plus icon to create a new playlist"
            header: Rectangle
            {
                color: "#212121"
                width: parent.width
                height: mainParent.height/4 - 5
                Icon
                {
                    height: parent.height
                    anchors.left: createText.right
                    anchors.leftMargin: 5
                    icon: IconType.plus
                    color: "#E91E63"
                }

                AppText
                {
                    id: createText
                    text: "Create new"
                    anchors.centerIn: parent
                    color: "#E91E63"
                }
                Rectangle
                {
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    color: "#E91E63"
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: nativeUtils.displayTextInput("Create playlist","Playlist name","","","Create","Cancel")
                }
            }
            model: playlistModel
            delegate: SimpleRow
            {
                text: plOption
                style.backgroundColor: "#212121"
                style.dividerColor: "#66000000"
                style.textColor: "white"
                onSelected:
                {
                    mainParent.close()
                    LOGIC.addToThisPlaylist(text)
                    var itm = database.getValue(text)
                    if(itm !== undefined)
                    {
                        playlistSongModel.clear()
                        for(var i=0; i<itm.length; ++i)
                        {
                            playlistSongModel.append({"fileName":itm[i]})
                        }
                    }
                }
            }

            Connections
            {
                target: nativeUtils
                onTextInputFinished:
                {
                    if(accepted)
                    {
                        mainParent.close()
                        LOGIC.createNewPlaylist(enteredText)
                    }
                }
            }
        }
    }

    onOpened: { opacity = 1.0 }
    onClosed: { opacity = 0.0 }
    Component.onCompleted:
    {
        var list = database.getValue("playlistNames")
        if(list === undefined)
            console.log("no playlist")
        else
        {
            for(var i=0; i<list.length; ++i)
            {
                playlistModel.append({"plOption":list[i]})
            }
        }
    }
}
