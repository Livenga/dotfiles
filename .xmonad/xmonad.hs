import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W

import Control.Monad (liftM2)
import System.IO

import XMonad.Actions.WindowGo
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.Place
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.DragPane
import XMonad.Layout.Gaps
import XMonad.Layout.IM
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Run
import XMonad.Util.SpawnOnce


myWorkspaces = ["1", "2", "3", "4", "5", "6", "7"]

modm = mod4Mask

colorBlue     = "#857da9"
colorGreen    = "#88b986"
colorGray     = "#676767"
colorWhite    = "#d3d7cf"
colorGrayAlt  = "#313131"
colorNormalbg = "#1a1e1b"

main :: IO()
main = do
  wsbar <- spawnPipe myWsBar
  xmonad $ defaultConfig
    { borderWidth        = 2
    , terminal           = "urxvt"
    , normalBorderColor  = colorGray
    , focusedBorderColor = colorGreen
    , startupHook        = myStartupHook
    , manageHook         = placeHook myPlacement <+> myManageHookShift <+> myManageHookFloat <+> manageDocks
    , layoutHook         = toggleLayouts (noBorders Full) $ avoidStruts $ myLayout
    , logHook            = myLogHook wsbar
    , workspaces         = myWorkspaces
    , modMask            = modm }


myWsBar  = "xmobar $HOME/.xmobarrc"

myLayout = (spacing 18 $ ResizableTall 1 (3/100) (3/5) [])
  ||| (spacing 2 $ (dragPane Horizontal (1/10) (1/2)))
  ||| (dragPane Vertical (1/10) (1/2))

--myStartupHook = do
  --setWMName "LG3D"
myStartupHook =
  setWMName "LG3D"


myManageHookShift = composeAll
  [ className =? "Firefox"  --> doShift " browser "
  , className =? "Mplayer"  --> doShift " media "
  ]

myManageHookFloat = composeAll
  [ className =? "MPlayer" --> doFloat
  , className =? "Gimp"    --> doFloat
  ]

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_) -> [ws, t]
                , ppCurrent         = xmobarColor colorGreen colorNormalbg . \s -> "●"
                , ppUrgent          = xmobarColor colorWhite colorNormalbg . \s -> "○"
                , ppVisible         = xmobarColor colorWhite colorNormalbg . \s -> "○"
                , ppHidden          = xmobarColor colorWhite colorNormalbg . \s -> "○"
                , ppHiddenNoWindows = xmobarColor colorGray  colorNormalbg . \s -> "○"
                , ppTitle           = xmobarColor colorWhite colorNormalbg
                , ppWsSep           = " "
                , ppSep             = "  "
                }

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h}
--myLogHook h = dynamicLogWithPP $ defaultPP { ppOutput = hPutStrLn h
                                           --, ppVisible = wrap "(" ")"
                                           --}
myPlacement = fixed(0.5, 0.5)
