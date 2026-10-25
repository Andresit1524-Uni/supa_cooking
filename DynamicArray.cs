using System;
using System.Collections;
using System.Collections.Generic;

public class DynamicArray<T>
{
    private T[] _data;
    private int _size;
    private int _capacity;

    // Constructor para inicializar una nueva lista con una capacidad por defecto
    public DynamicArray(int initialCapacity = 4){
        _capacity = initialCapacity > 0 ? initialCapacity : 4;
        _data = new T[_capacity];
        _size = 0;
    }

    // Retorna la cantidad actual de elementos en la estructura
    public int Size => _size;

    // Verifica si la estructura está vacía
    public bool IsEmpty => _size == 0;

    // Método privado para redimensionar el arreglo cuando se alcanza la capacidad máxima
    private void Resize() {
        _capacity *= 2; // Duplicar la capacidad
        T[] newData = new T[_capacity];

        // Copiar los elementos manualmente sin usar métodos de librería preexistentes
        for (int i = 0; i < _size; i++){
            newData[i] = _data[i];
        }

        _data = newData;
    }

    // Insertar un elemento al final de la estructura
    public void AddLast(T item){
        if (_size >= _capacity){
            Resize();
        }

        _data[_size] = item;
        _size++;
    }

    // Insertar un elemento al inicio de la estructura
    public void AddFirst(T item){
        InsertAt(0, item);
    }

    // Insertar en una posición (índice) específica
    public void InsertAt(int index, T item){
        if (index < 0 || index > _size){
            throw new IndexOutOfRangeException("El índice está fuera de los límites del arreglo.");
        }

        if (_size >= _capacity){
            Resize();
        }

        // Desplazar los elementos hacia la derecha manualmente
        for (int i = _size; i > index; i--){
            _data[i] = _data[i - 1];
        }

        _data[index] = item;
        _size++;
    }

    // Eliminar y retornar el último elemento
    public T RemoveLast(){
        if (IsEmpty){
            throw new InvalidOperationException("No se puede eliminar de una estructura vacía.");
        }

        int lastIndex = _size - 1;
        T removedItem = _data[lastIndex];
        
        _data[lastIndex] = default(T)!; // Limpiar la referencia para el recolector de basura
        _size--;

        return removedItem;
    }

    // Eliminar y retornar el primer elemento
    public T RemoveFirst(){
        return RemoveAt(0);
    }

    // Eliminar un elemento en un índice específico
    public T RemoveAt(int index){
        if (index < 0 || index >= _size){
            throw new IndexOutOfRangeException("El índice está fuera de los límites del arreglo.");
        }

        T removedItem = _data[index];

        // Desplazar los elementos hacia la izquierda manualmente
        for (int i = index; i < _size - 1; i++){
            _data[i] = _data[i + 1];
        }

        _size--;
        _data[_size] = default(T)!; // Limpiar la referencia

        return removedItem;
    }

    // Acceder a un elemento dado su índice
    public T GetAt(int index){
        if (index < 0 || index >= _size){
            throw new IndexOutOfRangeException("El índice está fuera de los límites del arreglo.");
        }

        return _data[index];
    }

    // Buscar un valor y retornar su índice (-1 si no se encuentra)
    public int Search(T value){
        for (int i = 0; i < _size; i++){
            // Uso de EqualityComparer para comparar tipos genéricos de forma segura
            if (EqualityComparer<T>.Default.Equals(_data[i], value)){
                return i;
            }
        }

        return -1; // Valor no encontrado
    }

    // Limpiar toda la estructura de datos
    public void Clear(){
        for (int i = 0; i < _size; i++){
            _data[i] = default(T)!;
        }
        
        _size = 0;
    }


    // MÉTODOS ADICIONALES QUE PODRÍAN SER ÚTILES

    // 1. Contains: Verifica si un elemento específico ya existe en la estructura
    public bool Contains(T item){
        return Search(item) != -1;
    }

    // 2. IEnumerable<T>: Permite recorrer la estructura usando un bucle `foreach`
    public IEnumerator<T> GetEnumerator(){
        for (int i = 0; i < _size; i++){
            yield return _data[i];
        }
    }

    // Implementación requerida por la interfaz no genérica de IEnumerable
    IEnumerator IEnumerable.GetEnumerator(){
        return GetEnumerator();
    }

    // 3. ToArray: Crea y retorna una copia de los elementos en forma de arreglo nativo tradicional.
    public T[] ToArray(){
        T[] result = new T[_size];
        
        for (int i = 0; i < _size; i++){
            result[i] = _data[i];
        }

        return result;
    }

    // 4. TrimExcess: Ajusta la capacidad interna del arreglo para que coincida con el tamaño real, para optimizar recursos y liberar memoria
    public void TrimExcess(){
        if (_size < _capacity){
            _capacity = _size > 0 ? _size : 4; // Mantiene un tamaño mínimo por seguridad
            T[] newData = new T[_capacity];

            for (int i = 0; i < _size; i++){
                newData[i] = _data[i];
            }

            _data = newData;
        }
    }
}