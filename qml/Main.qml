import VPlayApps 1.0
import VPlay 1.0
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtMultimedia 5.8
import "AppLogic.js" as LOGIC

App {
    id: root
    readonly property string controlColor: "#262673"
    property string startTime: "0:0"
    property string endTime: "0:0"
    property string currentSongName: ""
    property string bgimage: "../assets/cyan-music.jpg"
    property var songRow: undefined
    readonly property string keyString: "AF83995C2734BB4BD8ACD38745DB92A5690BA06E724E5
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

    licenseKey: keyString

    onInitTheme:
    {
        Theme.navigationBar.backgroundImageSource = bgimage
        Theme.navigationBar.titleColor = "#001a1a"
        Theme.tabBar.backgroundColor = "#1affff"
    }

    SongPlayerPage
    {
        id: playingpage
    }

    Navigation
    {
        id: mainNav
        NavigationItem
        {
            id: songsItem
            title: "Songs"
            icon: IconType.music
            NavigationStack
            {
                id: songsStack
                SongPage { id: mainPage }
            }
        }

        NavigationItem
        {
            id: aboutNavItem
            icon: IconType.info
            title: "Info"
            NavigationStack
            {
                id: aboutNavStack
                AboutPage { id: aboutpage }
            }
        }
    }

    MediaPlayer
    {
        id: batplayer
        playlist: mainplaylist
        onPositionChanged:
        {
            LOGIC.calculateRemTime(position)
        }
        onDurationChanged:
        {
            LOGIC.calculateTotalTime(duration)
        }
    }
    Playlist
    {
        id: mainplaylist
        onCurrentIndexChanged:
        {
            console.log("cicd")
            LOGIC.songChanged(currentItemSource)
        }
    }
}
