# minecraft-profile
SuperSaix's 1.12.2 Minecraft "profile".

The goal of this project is to define a comprehensive "modpack" in code. You'll notice that this repository accurately maps to the contents of the "/.minecraft" directory, such that this "profile" can be dropped into "/.minecraft" as a plug-and-play Minecraft experience!

SuperSaix's Minecraft profile contains mods (including an inter-mod compatibility mod), configuration for those mods, a resource pack and a shader pack all maintained in this repository and the repositories that are its submodules. These repositories are maintained by the SuperSaix organization on Git-Hub: https://github.com/supersaix

## Installation
1. Install [Forge for Minecraft 1.12.2](https://files.minecraftforge.net/maven/net/minecraftforge/forge/index_1.12.2.html).
2. Download and add the appropriate v1.12.2 jars to /mods/:
 * [Better Foliage](https://minecraft.curseforge.com/projects/better-foliage/files) (Recommended)
 * [Cave Root](https://minecraft.curseforge.com/projects/cave-root/files) (Recommended)
 * [Hwyla](https://minecraft.curseforge.com/projects/hwyla/files) (Recommended)
 * [Open Terrain Generator](https://minecraft.curseforge.com/projects/open-terrain-generator/files) (Required)
 * [Optifine](https://optifine.net/downloads) (Required)
 * [Mantle](https://minecraft.curseforge.com/projects/mantle/files) (Required)
 * [MapWriter 2](https://minecraft.curseforge.com/projects/mapwriter-2/files) (Recommended)
 * [Venomous Fangs](https://minecraft.curseforge.com/projects/venomous-fangs/files) (Required)
3. Run Compile-ModSource.ps1 to build the mod sources in the /source/ directory. Currently you'll have to manually move the outputs of these builds to the /mods/ directory. If this is your first time, you'll need to run the script with the -Init parameter first.
