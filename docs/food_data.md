## Estructura de los datos

### Ingredientes y recetas
Primeramente, usaremos un enum para almacenar una lista directa de los ingredientes:

```mermaid
classDiagram

%% Autoload de datos
namespace FoodData {
    class Ingredients {
        <<enum>>
        ...
    }

    class Dishes {
        <<enum>>
        ...
    }
}

%% Sprites
class FoodSprites {
    <<Resource>>
    +Dictionary~Ingredients, Texture2D~ ingredient_sprites
    +Dictionary~Dishes, Texture2D~ dish_sprites
}

%% Recetas
class FoodRecipes {
    +Dictionary~Dishes, Array~Ingredients~~ recipes_ingredients
}

FoodSprites --o Ingredients
FoodSprites --o Dishes
FoodRecipes --o Dishes
```

Se implementarán en GDScript debido a que C# no permite exportar genéricos, los cuales eran nececsarios para usar nuestro `DynamicArray`.
