import QtQuick 2.9
import VPlayApps 1.0
import QtQuick.Controls 2.2
import "JS/AppLogic.js" as LOGIC

Page
{
    id: mainPage
    title: "playlist"
    Rectangle
    {
        anchors.fill: parent
        AppListView
        {
            id: playlistSongList
            anchors.fill: parent
            backgroundColor: propertycontainer.darkColor
            model: playlistSongModel
            delegate: SimpleRow
            {
                property string filePath
                text: fileName
                filePath: fileURL
                style.backgroundColor: propertycontainer.darkColor
                Component.onCompleted: {console.log(text)}
            }
        }
    }
}
