import QtQuick 2.9
import VPlayApps 1.0
import QtQuick.Controls 2.2
import "AppLogic.js" as LOGIC

Page
{
    id: mainPage
    title: "playlist"
    property var songModel: undefined

    AppListView
    {
        id: playlistSongList
        backgroundColor: "#212121"
        model: songModel
        delegate: SimpleRow
        {
            property string filePath
            text: (songModel === undefined ? "" : fileName)
            filePath: (songModel === undefined ? "" : fileURL)
            style.backgroundColor: "#212121"
            Component.onCompleted: {console.log(text)}
        }
    }
}