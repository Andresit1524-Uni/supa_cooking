#if TOOLS
using Godot;

namespace DataStructures;

[Tool]
public partial class DataStructuresPlugin : EditorPlugin
{
    public override void _EnterTree()
    {
        GD.Print("Plugin Data Structures activado.");
    }

    public override void _ExitTree()
    {
        GD.Print("Plugin Data Structures desactivado.");
    }
}
#endif
