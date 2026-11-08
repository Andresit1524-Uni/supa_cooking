using System;
using System.Diagnostics;
using System.IO;
using DataStructures;

/// <summary>
/// Prueba de tiempos de ejecución para queue circular genérico. 
/// </summary>
/// <remarks>
/// Creado por Andres Sierra.
/// </remarks>
namespace DataStructures.Test
{
    public class QueueTest
    {
        public static void RunBenchmarks()
        {
            // Asegurar que exista el directorio de resultados
            string outputPath = Path.Combine("Test", "TestResults", "queue_benchmarks.csv");
            Directory.CreateDirectory(Path.GetDirectoryName(outputPath)!);

            nt[] dataSizes = { 10, 100, 1000, 10000, 100000, 1000000 };

            using (StreamWriter writer = new StreamWriter(outputPath))
            {
                // Encabezados del CSV
                writer.WriteLine("N,Enqueue_ms,Peek_ms,Dequeue_ms");

                Console.WriteLine("Iniciando pruebas para Queue...");

                foreach (int n in dataSizes)
                {
                    Queue<int> queue = new Queue<int>();

                    // 1. Prueba Enqueue - O(1) amortizado
                    Stopwatch sw = Stopwatch.StartNew();
                    for (int i = 0; i < n; i++)
                    {
                        queue.Enqueue(i);
                    }
                    sw.Stop();
                    double enqueueTime = sw.Elapsed.TotalMilliseconds;

                    // 2. Prueba Peek - O(1) - Se guarda el valor devuelto para evitar eliminación por JIT
                    int dummySum = 0;
                    sw.Restart();
                    for (int i = 0; i < n; i++)
                    {
                        dummySum += queue.Peek();
                    }
                    sw.Stop();
                    double peekTime = sw.Elapsed.TotalMilliseconds;

                    // 3. Prueba Dequeue - O(1)
                    sw.Restart();
                    for (int i = 0; i < n; i++)
                    {
                        queue.Dequeue();
                    }
                    sw.Stop();
                    double dequeueTime = sw.Elapsed.TotalMilliseconds;

                    // Guardar fila en CSV
                    writer.WriteLine($"{n},{enqueueTime:F4},{peekTime:F4},{dequeueTime:F4}");
                    Console.WriteLine($"Completado N = {n}");
                }
            }

            Console.WriteLine($"Resultados guardados en: {outputPath}");
        }
    }
}
