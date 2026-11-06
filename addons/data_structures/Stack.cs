using System;

namespace DataStructures;

/// <summary>
/// Stack generico usando un DynamicArray.
/// </summary>
/// <remarks>
/// Creado por David Muñoz.
/// </remarks>
public class Stack<T> : DynamicArray<T>
{
    public Stack(int initialCapacity = 4) : base(initialCapacity)
    {
    }
    //Push implementando metodos del dinamicArray
    public void Push(T item)
    {
        AddLast(item);

    }
    // Pop tambien implementando cositas del dinamic array
    public T Pop()
    {
        //Por si la pila esta vacia
        if (Size == 0)
        {
            throw new InvalidOperationException("La pila esta vacia");
        }
        return RemoveLast();
    }

    public T Peek()
    {
        if (Size == 0)
        {
            throw new InvalidOperationException("La pila esta vacia");
        }
        return this[Size - 1];
    }
    public bool Equals(Stack<T> pila)
    {
        if(pila is not Stack<T> other) return false;
        if(ReferenceEquals(this, other)) return true;
        if (Size != other.Size) return false;
        for (int i = 0; i < Size; i++)
        {
            if(!this[i].Equals(pila[i])) return false;
        }
        return true;
    }
}
