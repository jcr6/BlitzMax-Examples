Strict
Framework jcr6.zlibdriver ' This will automatically import the main driver so importing that is not needed
Import jcr6.wad ' This will enable JCR6 to recognize a WAD file (both IWAD and PWAD alike) and get its directory
Import brl.map
Import brl.stream

Const File$ = "DOOM.WAD"

Global JD:TJCRDir = JCR_Dir(file)


' Easiest way to show all files this contains
For Local F$=EachIn MapKeys(JD.Entries)
	Print F
Next

'Please note, JCR6 will always sort this out (BlitzMax does this by default, and due to that, I made this the standard for all JCR versions in other languages to follow)





' Now let's read out all vertexes of the Map E1M5
Print "~n~nShowing all vertexes in Episode 1 Map 5!"
Global S:TStream = ReadStream(JCR_B(JD,"MAP_E1M5/VERTEXES")) ' BTW: JCR6 is case INSENSITIVE, so any entry found can be type in both upper and lower case so typing "map_E1M5/Vertexes" would work too.
Global i=0
While Not Eof(S)
	i:+1
	Print "Vertex #"+i+": ("+ReadShort(S)+","+ReadShort(S)+")" ' First 16-bit integer is the x coordinate, and the second 16-bit integer the y (16bit was a standard integer back in the MS-DOS days).
Wend
CloseStream S


Rem
 A few notes:
- You can also write JCR_B("DOOM.WAD","MAP_E1M5/VERTEXES") and that will also work, 
  however in serious game development I would recommend against it, as that would require 
  the file table to be re-loaded every time, and that can cause slowdowns.  And also if you 
  wanna do patches (which JCR6 also supports), that way of working denies access to that
  feature. (for patches I can write a different example)
- Please note that once JCR_Dir() is performed, you need to make sure that the file
  it has analysed (patches included if you did that later) may NOT be modified until
  either the program has ended, or if the data produced by it has been destroyed by
  the BlitzMax garbage collector. Modifications will otherwise lead to an exception.
- Please note the MAP_E1M5 folder. This is because in WAD after the E1M5 header it
  always has the same named files attached to the map. JCR6 does not support multiple
  files with the same name, and so the creation of the MAP_ folder. By the way, JCR6
  is sophisticated enough to also do this with DOOM2, and even with HEXEN, where
  the extra file "BEHAVIOR" is added which does not exist in DOOM, DOOM2 and 
  HERETIC. All files that are not part of maps, will just be in the 'root' folder.
- In this source I've assumed you have a LitteEndian CPU (which is for Windows the only kind), 
  if running this code on a BigEndian CPU the line "S = LittleEndianStream(S)" must be added after 
  the "Global S:TStream" line, and the module "BRL.EndianStream" must be imported as well.
