import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import System.IO

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
      spawn "setxkbmap -layout us,th"
      spawn "xset b off"
      spawn "xset dpms 0 600 1800"
      spawn "xautolock -time 15 -locker slock"


------------------------------------------------------------------------
-- Workspaces

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1:web","2:code","3","4","5","6","7","8","9"]


------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $ (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = toRational (2/(1+sqrt(5)::Double)) + 4/100 -- golden plus small padding

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------

myModMask = mod1Mask  -- left alt

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar"

  xmonad $ defaultConfig {

      borderWidth         = 2
     ,focusFollowsMouse   = False
     ,terminal            = "urxvt"
     ,modMask             = myModMask
     ,layoutHook          = myLayout
     ,startupHook         = myStartupHook
     ,handleEventHook     = fullscreenEventHook
     ,workspaces          = myWorkspaces


     ,manageHook = manageDocks <+> manageHook defaultConfig
     ,logHook = dynamicLogWithPP xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "skyblue" "" . shorten 50,
            ppLayout = const "" -- to disable the layout info on xmobar
      }


}`additionalKeys`
      [ ((myModMask, xK_x), kill) -- to kill app
      , ((myModMask, xK_f), spawn "nautilus")
      , ((myModMask .|. shiftMask, xK_F4), spawn "sudo shutdown -h now") -- to shutdown
      , ((myModMask .|. shiftMask, xK_r), spawn "sudo reboot") -- to restart
      , ((myModMask .|. shiftMask, xK_l ), sendMessage NextLayout)
      ]`removeKeys`     -- keys to remove
      [ (myModMask, xK_space)
      ]
