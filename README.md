LEffectLabel
============

iOS Text Label With Effect

You may use the LEffectLabel class files in your project directly, or you may follow the steps below to clone the repo and use it as static library in your project.

Integrating into your project as static library
-----------------------------------------------

1. clone the LEffectLabel git repository e.g. git clone git://github.com/lukagabric/LEffectLabel.git
2. add LEffectLabel.xcodeproj to your project, make sure "Copy items into ..." is unchecked
3. in your target's Build Phases, under Link Binary With Libraries, click on the (+) and add the libLEffectLabel.a library, CoreGraphics.framework and QuartzCore.framework.
4. add the relative path to the LEffectLabel header in your "User Header Search Path" Build Setting
5. add -ObjC and -all_load to Other Linker Flags in your target's build settings

