import QtQuick 2.0
import Qt.labs.folderlistmodel 2.2
import VPlayApps 1.0
import QtMultimedia 5.8

AppListView
{
    id: listview
    focus: true
    signal songIndex(int index, var row)
    signal songPath(string path)
    readonly property string linuxPath: "/root/Music"
    readonly property string nomusicText: "<b>Place your music files to internal storage's Music folder</b>"
    property bool optionRaised: false
    property variant androidPath: ["file:///sdcard/Music","file:///sdcard","file:///sdcard/Downloads",
                                   "file:///sdcard/UcDownloads","file:///storage/sdcard1",
                                   "file:///storage/sdcard1/Music","file:///storage/sdcard1/Downloads",
                                   "file:///storage/sdcard1/UcDownloads","file:///storage/sdcard1/shareit/audio",
                                   "file:///sdcard/shareit/audio"]

    Repeater
    {
        model:
        {
            if(Qt.platform.os === "android")
                return androidPath
            if(Qt.platform.os === "linux")
                return [linuxPath]
        }

        delegate: Item
        {
            Repeater
            {
                model: FolderListModel
                {
                    folder: modelData
                    caseSensitive: false
                    showDirs: false
                    nameFilters: ["*.mp3","*.wav","*.ogg","*.3gpp","*.mp4a"]
                }
                delegate: Item
                {
                    Text
                    {
                        Component.onCompleted:
                        {
                            var url = fileURL.toString()
                            mdl.append( {"fileName":fileName,"fileURL":url} )
                        }
                    }
                }
            }
        }
    }

    ListModel{id: mdl}

    model: mdl
    delegate: SimpleRow
              {
                  property string fullpath
                  text: fileName.toString()
                  fullpath: fileURL
                  iconSource: IconType.music
                  style.backgroundColor: "#212121"
                  style.dividerColor: "#66000000"
                  style.textColor: "white"
                  height: dp(70)
                  Component.onCompleted: { listview.songPath(fullpath) }
                  MouseArea
                  {
                      id: pressarea
                      anchors.fill: parent
                      onPressAndHold:
                      {
                          console.log("press and hold")
                          option.z = 1
                          option.visible = true
                          option.opacity = 1.0
                          optionRaised = true
                      }

                      onClicked:
                      {
                          listview.songIndex(index, parent)
                          iconSource = IconType.play
                      }
                  }
              }

    opacity: 0.7
    emptyText.text: nomusicText
    emptyText.color: "purple"

    SongOptions
    {
        id: option
    }
}
