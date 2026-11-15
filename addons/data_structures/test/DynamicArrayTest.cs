using System;
using System.Diagnostics;
using System.IO;
using Godot;

/// <summary>
/// Prueba de tiempos de ejecución para arreglo dinámico genérico.
/// </summary>
/// <remarks>
/// Creado por Andres Sierra. Corregido por Andrés López
/// </remarks>
namespace DataStructures.Test
{
    public class DynamicArrayTest
    {
        static readonly string outputPath = Path.Combine("test_results", "dynamic_array_benchmarks.csv");
        static readonly int[] dataSizes = [1, 10, 100, 1000, 10000, 100000];
        static readonly Random random = new(42); // Semilla fija para reproducibilidad

        public static void RunBenchmarks()
        {
            // Calentamiento
            TestAddLast(10);
            TestAddFirst(10);
            TestRemoveLast(10);
            TestSearch(10);

            Directory.CreateDirectory(Path.GetDirectoryName(outputPath)!);
            using (StreamWriter writer = new(outputPath))
            {
                writer.WriteLine("N; AddLast (ns); AddFirst (ns); RemoveLast (ns); Search (ns)");
                GD.Print("Iniciando pruebas para DynamicArray...");

                foreach (int n in dataSizes)
                {
                    // 1. Prueba AddLast - O(1) amortizado
                    double addLastTime = TestAddLast(n);
                    // 4. Prueba AddFirst - O(n) desplazando elementos con el N exacto
                    double addFirstTime = TestAddFirst(n);
                    // 3. Prueba RemoveLast - O(1)
                    double removeLastTime = TestRemoveLast(n);
                    // 2. Prueba Search - Caso promedio con valores aleatorios
                    double searchTime = TestSearch(n);

                    writer.WriteLine($"{n}; {addLastTime:F0}; {addFirstTime:F0}; {removeLastTime:F0}; {searchTime:F0}");
                    GD.Print($"[DynamicArray] Completado N = {n}");
                }
            }

            GD.Print($"Resultados de DynamicArray guardados en: {outputPath}");
        }

        private static double TestAddLast(int n)
        {
            DynamicArray<int> arrayForAdd = [];

            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                arrayForAdd.AddLast(i);
            }

            sw.Stop();
            return sw.Elapsed.TotalNanoseconds / n; // Promedio
        }

        private static double TestSearch(int n)
        {
            DynamicArray<int> arrayForAdd = [];
            // Llena el arreglo
            for (int i = 0; i < n; i++)
            {
                arrayForAdd.AddLast(random.Next(0, n));
            }

            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                _ = arrayForAdd.Search(random.Next(0, n));
            }

            sw.Stop();
            return sw.Elapsed.TotalNanoseconds / n;
        }

        private static double TestRemoveLast(int n)
        {
            DynamicArray<int> arrayForAdd = [];
            // Llena el arreglo
            for (int i = 0; i < n; i++)
            {
                arrayForAdd.AddLast(i);
            }

            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                arrayForAdd.RemoveLast();
            }

            sw.Stop();
            return sw.Elapsed.TotalNanoseconds / n;
        }

        private static double TestAddFirst(int n)
        {
            DynamicArray<int> arrayForAddFirst = [];

            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                arrayForAddFirst.AddFirst(i);
            }

            sw.Stop();
            return sw.Elapsed.TotalNanoseconds / n;
        }
    }
}
