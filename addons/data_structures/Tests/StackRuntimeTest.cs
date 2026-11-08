using System;
using System.Diagnostics;
using System.IO;
using DataStructures;

/// <summary>
/// Prueba de tiempos de ejecución para stack genérico que usa un DynamicArray. 
/// </summary>
/// <remarks>
/// Creado por Andres Sierra.
/// </remarks>
namespace DataStructures.Test
{
    public class StackTest
    {
        public static void RunBenchmarks()
        {
            // Asegurar que exista el directorio de resultados
            string outputPath = Path.Combine("Test", "TestResults", "stack_benchmarks.csv");
            Directory.CreateDirectory(Path.GetDirectoryName(outputPath)!);

            int[] dataSizes = { 1000, 10000, 50000, 100000, 500000, 1000000 };

            using (StreamWriter writer = new StreamWriter(outputPath))
            {
                // Encabezados del CSV
                writer.WriteLine("N,Push_ms,Peek_ms,Pop_ms");

                Console.WriteLine("Iniciando pruebas para Stack...");

                foreach (int n in dataSizes)
                {
                    Stack<int> stack = new Stack<int>();

                    // 1. Prueba Push - O(1) amortizado
                    Stopwatch sw = Stopwatch.StartNew();
                    for (int i = 0; i < n; i++)
                    {
                        stack.Push(i);
                    }
                    sw.Stop();
                    double pushTime = sw.Elapsed.TotalMilliseconds;

                    // 2. Prueba Peek - O(1) repetido
                    sw.Restart();
                    for (int i = 0; i < 10000; i++)
                    {
                        _ = stack.Peek();
                    }
                    sw.Stop();
                    double peekTime = sw.Elapsed.TotalMilliseconds;

                    // 3. Prueba Pop - O(1)
                    sw.Restart();
                    for (int i = 0; i < n; i++)
                    {
                        stack.Pop();
                    }
                    sw.Stop();
                    double popTime = sw.Elapsed.TotalMilliseconds;

                    // Guardar fila en CSV
                    writer.WriteLine($"{n},{pushTime:F4},{peekTime:F4},{popTime:F4}");
                    Console.WriteLine($"Completado N = {n}");
                }
            }

            Console.WriteLine($"Resultados guardados en: {outputPath}");
        }
    }
}