using System.Diagnostics;
using System.IO;
using Godot;

/// <summary>
/// Prueba de tiempos de ejecución para queue circular genérico.
/// </summary>
/// <remarks>
/// Creado por Andres Sierra. Corregido por Andrés López
/// </remarks>
namespace DataStructures.Test
{
    public class QueueRuntimeTest
    {
        static readonly string outputPath = Path.Combine("test_results", "queue_benchmarks.csv");
        static readonly int[] dataSizes = [1, 10, 100, 1000, 10000, 100000];

        public static void RunBenchmarks()
        {
            // Calentamiento
            TestEnqueue(10);
            TestPeek(10);
            TestDequeue(10);

            Directory.CreateDirectory(Path.GetDirectoryName(outputPath)!);

            using (StreamWriter writer = new(outputPath))
            {
                writer.WriteLine("N; Enqueue (ns); Peek (ns); Dequeue (ns)");
                GD.Print("Iniciando pruebas para Queue...");

                foreach (int n in dataSizes)
                {
                    // 1. Prueba Enqueue - O(1) amortizado
                    double enqueueTime = TestEnqueue(n);
                    // 2. Prueba Peek - O(1)
                    double peekTime = TestPeek(n);
                    // 3. Prueba Dequeue - O(1)
                    double dequeueTime = TestDequeue(n);

                    writer.WriteLine($"{n}; {enqueueTime:F0}; {peekTime:F0}; {dequeueTime:F0}");
                    GD.Print($"[Queue] Completado N = {n}");
                }
            }

            GD.Print($"Resultados de Queue guardados en: {outputPath}");
        }

        private static double TestEnqueue(int n)
        {
            Queue<int> queue = new();

            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                queue.Enqueue(i);
            }

            sw.Stop();
            return sw.Elapsed.TotalNanoseconds / n; // Promedio
        }

        private static double TestPeek(int n)
        {
            Queue<int> queue = new();
            for (int i = 0; i < n; i++)
            {
                queue.Enqueue(i);
            }

            int dummySum = 0;
            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                dummySum += queue.Peek();
            }

            sw.Stop();
            _ = dummySum;
            return sw.Elapsed.TotalNanoseconds / n; // Promedio
        }

        private static double TestDequeue(int n)
        {
            Queue<int> queue = new();
            for (int i = 0; i < n; i++)
            {
                queue.Enqueue(i);
            }

            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                queue.Dequeue();
            }

            sw.Stop();
            return sw.Elapsed.TotalNanoseconds / n; // Promedio
        }
    }
}
