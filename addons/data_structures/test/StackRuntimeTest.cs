using System;
using System.Diagnostics;
using System.IO;
using Godot;

/// <summary>
/// Prueba de tiempos de ejecución para stack genérico que usa un DynamicArray. 
/// </summary>
/// <remarks>
/// Creado por Andres Sierra. Corregido por Andrés López
/// </remarks>
namespace DataStructures.Test
{
    public class StackRuntimeTest
    {
        static readonly string outputPath = Path.Combine("test_results", "stack_benchmarks.csv");
        static readonly int[] dataSizes = [1, 10, 100, 1000, 10000, 100000];

        public static void RunBenchmarks()
        {
            // Calentamiento
            TestPush(10);
            TestPeek(10);
            TestPop(10);

            Directory.CreateDirectory(Path.GetDirectoryName(outputPath)!);

            using (StreamWriter writer = new(outputPath))
            {
                writer.WriteLine("N; Push (ns); Peek (ns); Pop (ns)");
                GD.Print("Iniciando pruebas para Stack...");

                foreach (int n in dataSizes)
                {
                    // 1. Prueba Push - O(1) amortizado
                    double pushTime = TestPush(n);
                    // 2. Prueba Peek - O(1)
                    double peekTime = TestPeek(n);
                    // 3. Prueba Pop - O(1)
                    double popTime = TestPop(n);

                    writer.WriteLine($"{n}; {pushTime:F0}; {peekTime:F0}; {popTime:F0}");
                    GD.Print($"[Stack] Completado N = {n}");
                }
            }

            GD.Print($"Resultados de Stack guardados en: {outputPath}");
        }

        private static double TestPush(int n)
        {
            Stack<int> stack = new();

            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                stack.Push(i);
            }

            sw.Stop();
            return sw.Elapsed.TotalNanoseconds / n; // Promedio
        }

        private static double TestPeek(int n)
        {
            Stack<int> stack = new();
            for (int i = 0; i < n; i++)
            {
                stack.Push(i);
            }

            int dummySum = 0;
            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                dummySum += stack.Peek();
            }

            sw.Stop();
            _ = dummySum;
            return sw.Elapsed.TotalNanoseconds / n; // Promedio
        }

        private static double TestPop(int n)
        {
            Stack<int> stack = new();
            for (int i = 0; i < n; i++)
            {
                stack.Push(i);
            }

            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < n; i++)
            {
                stack.Pop();
            }

            sw.Stop();
            return sw.Elapsed.TotalNanoseconds / n; // Promedio
        }
    }
}
