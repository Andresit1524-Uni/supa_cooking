using System;
using System.Collections;
using System.Collections.Generic;

namespace DataStructures;

/// <summary>
/// Circular Queque generica.
/// </summary>
/// <remarks>
/// Creado por David Muñoz.
/// </remarks>
public class Queue<T> : DynamicArray<T>
{
    private int _front;
    private int _rear;

    public bool IsVoid => _size == 0;

    // Constructor de la cola
    public Queue(int initialCapacity = 4) : base(initialCapacity)
    {
        _front = 0;
        _rear = 0;
    }

    public int Count => _size;

    // Encolamos al final de la pila
    public void Enqueue(T item)
    {
        if (_size == _capacity) Resize();
        _data[_rear] = item;
        _rear = (_rear + 1) % _capacity;
        _size++;
    }

    // Desencolamos al inicio de la pila
    public T Dequeue()
    {
        if (IsVoid) throw new InvalidOperationException("La cola esta vacia");
        T item = _data[_front];
        _front = (_front + 1) % _capacity;
        _size--;
        return item;
    }

    // Mostramos el primer dato de la pila
    public T Peek()
    {
        if (IsVoid) throw new InvalidOperationException("La cola esta vacia");
        return _data[_front];
    }

    // Sobreescribimos resize para actualizar valores de capacity, front y rear
    protected override void Resize()
    {
        int newCapacity = _capacity * 2;
        T[] newData = new T[newCapacity];

        for (int i = 0; i < _size; i++) newData[i] = _data[(_front + i) % _capacity];

        _data = newData;
        _capacity = newCapacity;
        _front = 0;
        _rear = _size;
    }
}
