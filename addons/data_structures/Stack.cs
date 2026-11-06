using System;

namespace DataStructures;

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
    // Pop tambien implementando cositas dl dinamic array
    public T Pop()
    {
        //Por si la pila esta vacia
        if (Size == 0)
        {
            throw new InvalidOperationException("La pila esta vacia");
        }
        int last = Size - 1;
        T item = this[last];
        RemoveLast();
        return item;
    }

    public T Peek()
    {
        if (Size == 0)
        {
            throw new InvalidOperationException("La pila esta vacia");
        }
        return this[Size - 1];
    }
}
