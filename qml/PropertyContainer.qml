import QtQuick 2.0
import VPlayApps 1.0
import QtMultimedia 5.8

Item {
    id: propertyHolder
    // readonly properties
    readonly property int sequentialMode: Playlist.Sequential
    readonly property int randomMode: Playlist.Random
    readonly property int repeatAllMode: Playlist.Loop
    readonly property int repeatCurrentMode: Playlist.CurrentItemInLoop
    readonly property string playIcon: IconType.play
    readonly property string pauseIcon: IconType.pause
    // changeable properties
    // color properties
    property string darkColor: "#212121"
    property string lightGrey: "#9E9E9E"
    property string drowerTextColor: "#E1BEE7"
    property string lightPink: "#E91E63"
    property string gradientDown: "red"
    property string scrollBarColor: "#EEEEEE"
    property string listDividerColor: "#66000000"
    property string detailTextColor: "#b2b2b2"
    property string textColor: "white"
    property string fullTransparent: "transparent"
    property string settingGradientUp: "#212121"
    property string settingGradientDown: "#003300"
    property var transparentRgbColor: Qt.rgba(0,0,0, 0.75)
    property Gradient sidebarGradient: Gradient
    {
        GradientStop {position: 0.0; color: lightPink}
        GradientStop {position: 1.0; color: gradientDown}
    }
    property Gradient settingBgGradient: Gradient
    {
        GradientStop {
            id: upGrd
            position: 0.4; color: settingGradientUp
            Behavior on color {
                ColorAnimation {duration: 1000}
            }
        }
        GradientStop {
            id: dwnGrd
            position: 1.0; color: settingGradientDown
            Behavior on color {
                ColorAnimation {duration: 1000}
            }
        }
    }
    // background images
    property string mainBgImage: "../assets/bat-dark-main.jpg"
    property string defaultCoverArt: "../assets/bat-dark-playing.jpg"
    property string settingBgImage: "../assets/bat-dark-main.jpg"
    property string coverArt: defaultCoverArt
    // other properties
    property real xAxis: (width - timermenu.width)/2
    property real yAxix: (height - timermenu.height)/2
    property real opWidth: (width) - (width/5)
    property real opHeight: height/2 - height/6
    property real pageTotalWidth: 0.0
    property real pageProgressWidth: 0.0
    property real tmpProgressWidth: 0.0
    property string pIcon: IconType.play
    property var songRow: undefined
    property int totalDuration: 0
    property bool isFirstTime: true
    property int currentSongIndex: 0
    property bool ifCoverArt: false
    property bool ifMainImageOn: true
    property bool isLoading: true
    property string remTime: "00:00"
    property string totalTime: "00:00"
    property string currentSongName: ""
    property string selectedSongPath: ""
    property string selectedSongName: ""
    property string currentPlayingArtist: ""
    property int selectedSongIndex: -1
    property string noPlaylistText: "No playlist found, to create one long press on any song "+
                                     "and select 'Add to playlist'"
    // license key
    readonly property string licenseKeyString: "AF83995C2734BB4BD8ACD38745DB92A5690BA06E724E5
                                3A8CA86DEA8D70D7D15C07934C78DEC3DEDA6BECC0A69
                                E1F459A2E505BCCCC03BFE17D923BC0F475F8D8695A87
                                66C234491D8D66B8078E9D1F3E25F8B3ADE396DB04CC0
                                1C9A6C20CCD729E6090CC7BAEB658D4AFD4A4970EE250
                                B3682FD1D147FC44F49E763F9C876D5DF163CF3FE0FCF
                                702985631000F791BA83E89803991D52F7F07BCB51DD1
                                A22C12054DA9C8A951276C592BAB5E07F7BD81280E4F3
                                9F3E4227A728FCDCAFAAF489B0A39F0A74FE0BA5842E2
                                480A1832E410063114C0A4761ADA79CEFAB506B3D5F77
                                09B7E0473DB408D7E654D537392E8724F7CCC1CA458C3
                                744CDAF97ADD653672CB9165AEAD8A9EE6B8E6D23AA0F
                                FDAB3A6D6E5ECB64BCBCD64CC434734B00A015546B4C6
                                13246ECA3BE90B893F8815D"
}
