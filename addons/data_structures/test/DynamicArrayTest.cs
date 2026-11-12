using System;
using System.Diagnostics;
using System.IO;

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
            string outputPath = Path.Combine("test_results", "dynamic_array_benchmarks.csv");
            Directory.CreateDirectory(Path.GetDirectoryName(outputPath)!);

            // Ajustado a potencias de 10 hasta 1,000,000
            int[] dataSizes = { 10, 100, 1000, 10000, 100000 };
            Random random = new Random(42); // Semilla fija para reproducibilidad

            using (StreamWriter writer = new StreamWriter(outputPath))
            {
                writer.WriteLine("N; AddLast (ms); AddFirst (ms); RemoveLast (ms); Search (ms)");
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

                    // 2. Prueba Search - Caso promedio con valores aleatorios
                    int targetValue = random.Next(0, n); // Buscar un elemento aleatorio que existe en el rango
                    sw.Restart();
                    int foundIndex = arrayForAdd.Search(targetValue);
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

                    // 4. Prueba AddFirst - O(n) desplazando elementos con el N exacto
                    // Nota: En N = 1,000,000 tomará un par de segundos debido a O(n^2) total, pero mantendrá la medición precisa
                    DynamicArray<int> arrayForAddFirst = new DynamicArray<int>();
                    sw.Restart();
                    for (int i = 0; i < n; i++)
                    {
                        arrayForAddFirst.AddFirst(i);
                    }
                    sw.Stop();
                    double addFirstTime = sw.Elapsed.TotalMilliseconds;

                    writer.WriteLine($"{n}; {addLastTime:F4}; {addFirstTime:F4}; {removeLastTime:F4}; {searchTime:F4}");
                    Console.WriteLine($"[DynamicArray] Completado N = {n}");
                }
            }

            Console.WriteLine($"Resultados de DynamicArray guardados en: {outputPath}");
        }
    }
}
