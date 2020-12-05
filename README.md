# Reaper-Scripts
Some of the Reaper scripts I wrote

Scripts Description:

WilScript - Add 10dB RMS.lua
- As the name states, this script adds 10dB to the file's RMS value. Also displays the old and new RMS values and the volume increase between both.

Wilscript - Batch Process.lua
- Allows you to batch process files and override the originals, something that Reaper doesn't allow in its Batch Processing tool.
- You need to copy/paste the list of your files into the column A of a CSV, which the script will then ask you to load.
- You can easily do so by selecting all your files and Shift+right click them, then selecting "Copy as path"
-	Then open a new Reaper session
-	Create an empty track and put all your processing FX as this track’s FX chain
-	In the Render window, make sure your render Source setting is set to « Selected media items via master » - just click on Apply and close it afterwards
-	Launch the script, point to your CSV when prompted and voilà!

WilScript - Compare LUFS.lua
- Coming soon

WilScript - Display time of selected items.lua
- Coming soon

WilScript - Explode Multichannel.lua
- Only works on a 3+ channels file
- Can be used to explode a multichannel file coming from a multi-input recorder
- Doesn't actually renders new files but duplicate the file and solo one channel
- Also skips the first two channels as they are usually Stereo mixdowns of the whole recording

WilScript - Export RMS Loudness.lua
- Coming soon

WilScript - Mute all tracks but not the selected one and its parents.lua
- Select the tracks you want to solo and run the script
- It will mute the whole session minus the selected tracks and their parents up to the master
- The difference between this and the solo function is that, by muting all other tracks, they are effectively disabled, which can be a true CPU-saver in a big session

WilScript - Remove 10dB RMS.lua
- As the name states, this script removes 10dB to the file's RMS value. Also displays the old and new RMS values and the volume increase between both.

WilScript - Sort Mono and Stereo files.lua
- Select a bunch of clips on the same track and run the script
- It will leave the mono files on their tracks and put the stereo files on the track below
