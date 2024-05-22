import System.IO 
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.DragPane
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Simplest
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.TwoPane
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Run


-- 
myTerminal           = "alacritty"
myBar                = "xmobar ~/.xmobarrc"
myBorderWidth        = 1

myNormalBorderColor  = "#262626"
myFocusedBorderColor = "#ededed"


main :: IO()

main = do
    wsbar <- spawnPipe myBar
    xmonad $ def { terminal           = myTerminal
                 , workspaces         = myWorkspaces
                 , modMask            = mod4Mask
                 , focusFollowsMouse  = True
                 , borderWidth        = myBorderWidth
                 , normalBorderColor  = myNormalBorderColor
                 , focusedBorderColor = myFocusedBorderColor
                 , logHook            = myLogHook wsbar
                 , layoutHook         = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout-- $ layoutHook def
                 , manageHook         = manageHook def <+> manageDocks
                 --, startupHook = myStartupHook
                 } `additionalKeys` myAdditionalKeys

gapWidth = 4
gwU      = 24
gwD      = 1
gwL      = 12 
gwR      = 12
myLayout = spacing gapWidth
            $ gaps [(U, gwU), (D, gwD), (L, gwL), (R, gwR)]
            $ (ResizableTall 1 (1/205) (120/205) [])
             ||| (TwoPane (1/205) (120/205))
             ||| Simplest

--
--myWorkspaces      = [ "1", "2", "3", "4", "5", "6", "7", "8", "9" ]
myWorkspaces      = [ "1", "2", "3", "4", "5" ]

--
myExtraWorkspaces = [(xK_0, "0")] -- list of (key, name)

--
myStartupHook     =
    setWMName "LG3D"

--
myAdditionalKeys  = [
                    ]

--
colorWhite     = "#d3d7cf"
colorB         = "#FFCA28"
colorGreen     = "#B2FF59"
colorLightGray = "#455A64"
--colorNormalbg = "#1a1e1b"
colorNormalbg  = "#1e1e1e"
colorWorkbg    = "#000"

myLogHook h = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn h }
myPP        = xmobarPP { ppTitle           = xmobarColor colorWhite     colorNormalbg
                       , ppCurrent         = xmobarColor colorGreen     colorWorkbg . \s -> s
                       , ppVisible         = xmobarColor colorB         colorWorkbg . \s -> s
                       , ppHidden          = xmobarColor colorB         colorWorkbg . \s -> s
                    -- , ppHiddenNoWindows = xmobarColor "#B0BEC5" colorWorkbg . \s -> s
                       , ppOrder           = \(ws:l:t:_) -> [ws,t]
                       , ppWsSep           = " "
                       , ppSep             = "  ::  "
                }
