using System;
using System.Collections;
using System.Collections.Generic;

namespace DataStructures;

/// <summary>
/// Stack generico usando un DynamicArray.
/// </summary>
/// <remarks>
/// Creado por David Muñoz.
/// </remarks>

// Heredamos de DynamicArray
public class Stack<T> : DynamicArray<T>
{
    //Constructor del Stack
    public Stack(int initialCapacity = 4) : base(initialCapacity)
    {
    }
    //Push: añadimos un dato al final de la lista
    public void Push(T item)
    {
        AddLast(item);
    }

    // Pop: Eliminamos el dato al final de la lista
    public T Pop()
    {
        //Por si la pila esta vacia
        if (Size == 0)
        {
            throw new InvalidOperationException("La pila esta vacia");
        }
        return RemoveLast();
    }
    // Consultar el ultimo dato del Stack
    public T Peek()
    {
        if (Size == 0)
        {
            throw new InvalidOperationException("La pila esta vacia");
        }
        return this[Size - 1];
    }
    //Comparar si es igual o no a otro stack
    public bool Equals(Stack<T> pila)
    {
        if (pila is not Stack<T> other) return false;
        if (ReferenceEquals(this, other)) return true;
        if (Size != other.Size) return false;
        for (int i = 0; i < Size; i++)
        {
            if (!this[i].Equals(pila[i])) return false;
        }
        return true;
    }
}
