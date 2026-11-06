using System;

namespace DataStructures;

/// <summary>
/// List generico usando un DynamicArray.
/// </summary>
/// <remarks>
/// Creado por David Muñoz.
/// </remarks>
public class List<T> : DynamicArray<T>
{
    public List(int initialCapacity = 4) : base(initialCapacity)
    {
    }


    // Agregar al final.
    public new void Add(T item) => AddLast(item);

    // Insertar en una posición dada.
    public void Insert(int index, T item) => InsertAt(index, item);

    // Eliminar la primera coincidencia por valor.
    public bool Remove(T item)
    {
        int index = Search(item);

        if (index == -1)
        {
            return false;
        }

        RemoveAt(index);
        return true;
    }

    // Obtener el primer elemento sin eliminarlo.
    public T First()
    {
        if (IsEmpty)
        {
            throw new InvalidOperationException("La lista está vacía.");
        }

        return GetAt(0);
    }

    // Obtener el último elemento sin eliminarlo.
    public T Last()
    {
        if (IsEmpty)
        {
            throw new InvalidOperationException("La lista está vacía.");
        }

        return GetAt(Size - 1);
    }

    public bool Equals(List<T> other)
    {
        if (other is null) return false;

        if (ReferenceEquals(this, other)) return true;

        if (Size != other.Size) return false;

        for (int i = 0; i < Size; i++)
        {
            if (!this[i].Equals(other[i])) return false;
        }
        
        return true;
    }
}
