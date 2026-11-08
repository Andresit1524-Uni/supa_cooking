using System;
using System.Diagnostics;
using System.IO;
using DataStructures;

/// <summary>
/// Prueba de tiempos de ejecución para arreglo dinámico genérico.
/// </summary>
/// <remarks>
/// Creado por Andres Sierra.
/// </remarks>
namespace DataStructures.Test
{
    public class DynamicArrayTest
    {
        public static void RunBenchmarks()
        {
            // Asegurar que exista el directorio de resultados
            string outputPath = Path.Combine("Test", "TestResults", "dynamic_array_benchmarks.csv");
            Directory.CreateDirectory(Path.GetDirectoryName(outputPath)!);

            int[] dataSizes = { 1000, 5000, 10000, 50000, 100000, 500000 };

            using (StreamWriter writer = new StreamWriter(outputPath))
            {
                // Encabezados del CSV
                writer.WriteLine("N,AddLast_ms,AddFirst_ms,RemoveLast_ms,Search_ms");

                Console.WriteLine("Iniciando pruebas para DynamicArray...");

                foreach (int n in dataSizes)
                {
                    // 1. Prueba AddLast - O(1) amortizado
                    DynamicArray<int> arrayForAdd = new DynamicArray<int>();
                    Stopwatch sw = Stopwatch.StartNew();
                    for (int i = 0; i < n; i++)
                    {
                        arrayForAdd.AddLast(i);
                    }
                    sw.Stop();
                    double addLastTime = sw.Elapsed.TotalMilliseconds;

                    // 2. Prueba Search - O(n) peores casos (buscando elemento al final o inexistente)
                    sw.Restart();
                    arrayForAdd.Search(-1); // Forzar recorrido completo
                    sw.Stop();
                    double searchTime = sw.Elapsed.TotalMilliseconds;

                    // 3. Prueba RemoveLast - O(1)
                    sw.Restart();
                    for (int i = 0; i < n; i++)
                    {
                        arrayForAdd.RemoveLast();
                    }
                    sw.Stop();
                    double removeLastTime = sw.Elapsed.TotalMilliseconds;

                    // 4. Prueba AddFirst - O(n) debido a desplazamientos constantes
                    DynamicArray<int> arrayForAddFirst = new DynamicArray<int>();
                    sw.Restart();
                    // Uso de un N más pequeño si N > 50000 para evitar pruebas excesivamente largas en O(n^2) total
                    int addFirstN = n > 50000 ? 50000 : n; 
                    for (int i = 0; i < addFirstN; i++)
                    {
                        arrayForAddFirst.AddFirst(i);
                    }
                    sw.Stop();
                    double addFirstTime = sw.Elapsed.TotalMilliseconds;

                    // Guardar fila en CSV
                    writer.WriteLine($"{n},{addLastTime:F4},{addFirstTime:F4},{removeLastTime:F4},{searchTime:F4}");
                    Console.WriteLine($"Completado N = {n}");
                }
            }

            Console.WriteLine($"Resultados guardados en: {outputPath}");
        }
    }
}