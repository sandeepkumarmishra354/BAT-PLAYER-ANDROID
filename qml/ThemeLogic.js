function applyTheme(theme)
{
    switch (theme)
    {
        case defaultTh:
            applyDefaultTheme()
            break
        case yellowTh:
            applyYellowTheme()
            break
        case blueTh:
            applyBlueTheme()
            break
        default:
            console.log("Theme Error")
    }
}
function applyDefaultTheme()
{
    propertycontainer.darkColor = "#212121"
    propertycontainer.lightGrey = "#9E9E9E"
    propertycontainer.drowerTextColor = "#E1BEE7"
    propertycontainer.lightPink = "#E91E63"
    propertycontainer.gradientDown = "red"
    propertycontainer.scrollBarColor = "#EEEEEE"
    propertycontainer.listDividerColor = "#66000000"
    propertycontainer.detailTextColor = "#b2b2b2"
    propertycontainer.textColor = "white"
    propertycontainer.settingGradientUp = propertycontainer.darkColor
    propertycontainer.mainBgImage = "../assets/bat-dark-main.jpg"
    propertycontainer.defaultCoverArt = "../assets/bat-dark-playing.jpg"
    propertycontainer.settingBgImage = propertycontainer.defaultCoverArt
    initTheme()
    console.log("default theme applied")
}
function applyYellowTheme()
{
    propertycontainer.darkColor = "#4d4d00"
    propertycontainer.lightGrey = "#9E9E9E"
    propertycontainer.drowerTextColor = "#E1BEE7"
    propertycontainer.lightPink = "yellow"
    propertycontainer.gradientDown = "#4d4d00"
    propertycontainer.scrollBarColor = "#EEEEEE"
    propertycontainer.listDividerColor = "#66000000"
    propertycontainer.detailTextColor = "#b2b2b2"
    propertycontainer.textColor = "white"
    propertycontainer.settingGradientUp = "#999900"
    propertycontainer.mainBgImage = "../assets/wolverine.jpg"
    propertycontainer.defaultCoverArt = "../assets/wolverine.jpg"
    propertycontainer.settingBgImage = propertycontainer.defaultCoverArt
    initTheme()
    console.log("yellow theme applied")
}
function applyBlueTheme()
{
    propertycontainer.darkColor = "#002966"
    propertycontainer.lightGrey = "#9E9E9E"
    propertycontainer.drowerTextColor = "#E1BEE7"
    propertycontainer.lightPink = "blue"
    propertycontainer.gradientDown = "#002966"
    propertycontainer.scrollBarColor = "#EEEEEE"
    propertycontainer.listDividerColor = "#66000000"
    propertycontainer.detailTextColor = "#b2b2b2"
    propertycontainer.textColor = "white"
    propertycontainer.settingGradientUp = "#002966"
    propertycontainer.mainBgImage = "../assets/blue-bg.jpg"
    propertycontainer.defaultCoverArt = "../assets/bat-blue.jpg"
    propertycontainer.settingBgImage = propertycontainer.defaultCoverArt
    initTheme()
    console.log("blue theme applied")
}

function initTheme()
{
    Theme.navigationBar.backgroundColor = propertycontainer.darkColor
    Theme.tabBar.backgroundColor = propertycontainer.darkColor
    Theme.tabBar.titleOffColor = propertycontainer.lightGrey
    Theme.colors.textColor = propertycontainer.textColor
    Theme.navigationAppDrawer.textColor = propertycontainer.drowerTextColor
    Theme.navigationAppDrawer.activeTextColor = propertycontainer.textColor
    Theme.navigationAppDrawer.backgroundColor = propertycontainer.darkColor
    Theme.navigationAppDrawer.itemBackgroundColor = propertycontainer.darkColor
    Theme.navigationAppDrawer.dividerColor = propertycontainer.darkColor
    Theme.colors.scrollbarColor = propertycontainer.scrollBarColor
}
