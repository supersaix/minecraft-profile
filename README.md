# minecraft-profile
SuperSaix's 1.12.2 Minecraft "profile".

The goal of this project is to define a comprehensive "modpack" in code. You'll notice that this repository accurately maps to the contents of the "/.minecraft" directory, such that this "profile" can be dropped into "/.minecraft" as a plug-and-play Minecraft experience!

SuperSaix's Minecraft profile contains mods (including an inter-mod compatibility mod), configuration for those mods, a resource pack and a shader pack all maintained in this repository and the repositories that are its submodules. These repositories are maintained by the SuperSaix organization on Git-Hub: https://github.com/supersaix

Mods forked for SuperSaix's profile:

* minecraft-caveroot (Cave Root) This mod adds several new plants to the game that grow exclusively in caves and provide food, light, and sticks to the cave-dwelling minecrafter.
* minecraft-familiarfauna (Familiar Fauna) This mod adds a number of new (friendly) mobs to the game including Deer, Turkeys and Pixies. 
* minecraft-mineralogy (Mineralogy) This mod overhauls Minecraft's mining experience by replacing the usual "stone" with "real-world geology".
* minecraft-natura (Natura) This mod adds new trees, bushes, mobs, tools, and more!
* minecraft-primitive (Primitive Mobs) This mod adds a number of new friendly and enemy mobs including Grove Sprites, Treasure Slimes and Spider Families!
* minecraft-roguelike (Roguelike Dungeons) This mod generates expansive new dungeons throughout the Minecraft world!

As well the John Smith Techinician's Remix resourcepack has been forked and includes resources for the forked mods as well as Minecraft to provide a cohesive Minecraft experience!

## Installation
1. Install [Forge for Minecraft 1.12.2](https://files.minecraftforge.net/maven/net/minecraftforge/forge/index_1.12.2.html).
2. Download and add the appropriate v1.12.2 jars to /mods/:
 * [Better Foliage](https://minecraft.curseforge.com/projects/better-foliage/files) (Recommended)
 * [Hwyla](https://minecraft.curseforge.com/projects/hwyla/files) (Recommended)
 * [kjlib](https://minecraft.curseforge.com/projects/kjlib/files) (Required)
 * [Open Terrain Generator](https://minecraft.curseforge.com/projects/open-terrain-generator/files) (Required)
 * [Optifine](https://optifine.net/downloads) (Required)
 * [Mantle](https://minecraft.curseforge.com/projects/mantle/files) (Required)
 * [MapWriter 2](https://minecraft.curseforge.com/projects/mapwriter-2/files) (Recommended)
 * [Venomous Fangs](https://minecraft.curseforge.com/projects/venomous-fangs/files) (Required)
3. Run Compile-ModSource.ps1 to build the mod sources in the /source/ directory. Currently you'll have to manually move the outputs of these builds to the /mods/ directory. If this is your first time, you'll need to run the script with the -Init parameter first.
