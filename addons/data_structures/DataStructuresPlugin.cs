#if TOOLS
using Godot;

[Tool]
public partial class DataStructuresPlugin : EditorPlugin
{
    public override void _EnterTree()
    {
        // Se ejecuta cuando el plugin se activa en Godot
        GD.Print("Plugin Data Structures activado.");
    }

    public override void _ExitTree()
    {
        // Se ejecuta cuando el plugin se desactiva
        GD.Print("Plugin Data Structures desactivado.");
    }
}
#endif
