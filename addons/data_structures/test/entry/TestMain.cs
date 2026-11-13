using Godot;
using DataStructures.Test;

/// <summary>
/// Orquestador de las pruebas de tiempo de ejecución de las estructuras de datos. 
/// </summary>
/// <remarks>
/// Creado por Andres Sierra y Andrés López.
/// </remarks>
public partial class TestMain : Node
{
	public override void _Ready()
	{
		DynamicArrayTest.RunBenchmarks();
		QueueRuntimeTest.RunBenchmarks();
		StackRuntimeTest.RunBenchmarks();
	}
}
