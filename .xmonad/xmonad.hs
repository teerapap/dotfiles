import XMonad
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Prompt
import XMonad.Prompt.Window
import XMonad.Util.EZConfig
import XMonad.Util.Run
import System.IO

import qualified XMonad.StackSet as W

------------------------------------------------------------------------
-- Gnome module with '--print-reply=literal' fixed
-- import XMonad.Config.Gnome
import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run (safeSpawn)

import qualified Data.Map as M

import System.Environment (getEnvironment)

-- $usage
-- To use this module, start with the following @~\/.xmonad\/xmonad.hs@:
--
-- > import XMonad
-- > import XMonad.Config.Gnome
-- >
-- > main = xmonad gnomeConfig
--
-- For examples of how to further customize @gnomeConfig@ see "XMonad.Config.Desktop".

gnomeConfig = desktopConfig
    { terminal = "gnome-terminal"
    , keys     = gnomeKeys <+> keys desktopConfig
    , startupHook = gnomeRegister >> startupHook desktopConfig }

gnomeKeys (XConfig {modMask = modm}) = M.fromList $
    []

-- | Launch the "Run Application" dialog.  gnome-panel must be running for this
-- to work.
gnomeRun :: X ()
gnomeRun = withDisplay $ \dpy -> do
    rw <- asks theRoot
    gnome_panel <- getAtom "_GNOME_PANEL_ACTION"
    panel_run   <- getAtom "_GNOME_PANEL_ACTION_RUN_DIALOG"

    io $ allocaXEvent $ \e -> do
        setEventType e clientMessage
        setClientMessageEvent e rw gnome_panel 32 panel_run 0
        sendEvent dpy rw False structureNotifyMask e
        sync dpy False

-- | Register xmonad with gnome. 'dbus-send' must be in the $PATH with which
-- xmonad is started.
--
-- This action reduces a delay on startup only only if you have configured
-- gnome-session>=2.26: to start xmonad with a command as such:
--
-- > gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string
gnomeRegister :: MonadIO m => m ()
gnomeRegister = io $ do
    x <- lookup "DESKTOP_AUTOSTART_ID" `fmap` getEnvironment
    whenJust x $ \sessionId -> safeSpawn "dbus-send"
            ["--session"
            ,"--print-reply=literal"
            ,"--dest=org.gnome.SessionManager"
            ,"/org/gnome/SessionManager"
            ,"org.gnome.SessionManager.RegisterClient"
            ,"string:xmonad"
            ,"string:"++sessionId]
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
      gnomeRegister
      spawn "sleep 5 && setxkbmap -layout us,th"
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
myLayout = avoidStruts $ smartBorders $ (tiled ||| Mirror tiled ||| Full)
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
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "jetbrains-android-studio"   --> doShift "2:code"
    ]

------------------------------------------------------------------------

myModMask = mod1Mask  -- left alt

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar"

  xmonad $ gnomeConfig {

      borderWidth         = 2
     ,focusFollowsMouse   = False
     ,terminal            = "urxvt"
     ,modMask             = myModMask
     ,layoutHook          = myLayout
     ,startupHook         = myStartupHook
     ,handleEventHook     = fullscreenEventHook
     ,workspaces          = myWorkspaces


     ,manageHook = manageDocks <+> myManageHook <+> manageHook gnomeConfig
     ,logHook = dynamicLogWithPP xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "skyblue" "" . shorten 50,
            ppLayout = const "" -- to disable the layout info on xmobar
      }


}`additionalKeys`
      [ ((myModMask, xK_e), kill) -- to kill app
      , ((myModMask, xK_f), spawn "nautilus")
      , ((myModMask, xK_g), windowPromptGoto defaultXPConfig) -- go to selected window
      , ((myModMask, xK_b), windowPromptBring defaultXPConfig) -- bring selected window to current workspace
      , ((myModMask .|. shiftMask, xK_l), spawn "slock") -- lock screen
      , ((myModMask .|. shiftMask, xK_m), windows W.swapMaster) -- swap to master
      , ((myModMask .|. shiftMask, xK_n), sendMessage NextLayout)
      ]`removeKeys`     -- keys to remove
      [ (myModMask, xK_space)
      , (myModMask, xK_Return)
      ]


