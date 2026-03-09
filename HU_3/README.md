# Base de Datos para Plataforma de Streaming – MongoDB

## Descripción General

Este proyecto implementa una **base de datos en MongoDB para una plataforma de streaming** similar a Netflix.
La base de datos permite almacenar información sobre usuarios, contenido disponible, calificaciones y listas personales donde los usuarios pueden guardar contenido para verlo más tarde.

El diseño sigue un **modelo NoSQL escalable**, lo que permite agregar nuevas funcionalidades en el futuro, como múltiples listas por usuario, recomendaciones o historial de visualización.

---

# Estructura de la Base de Datos

La base de datos está compuesta por las siguientes colecciones:

* `users`
* `content`
* `ratings`
* `lists`
* `list_items`

Cada colección representa una funcionalidad principal de la plataforma.

---

# Colecciones

## 1. users

Almacena la información de los usuarios de la plataforma.

Ejemplo de documento:

```json
{
  "_id": ObjectId(),
  "name": "Carlos",
  "email": "carlos@example.com",
  "created_at": ISODate()
}
```

Campos:

* `_id` → identificador único del usuario
* `name` → nombre del usuario
* `email` → correo electrónico del usuario
* `created_at` → fecha de creación de la cuenta

---

## 2. content

Almacena las películas y series disponibles en la plataforma.

Ejemplo de documento:

```json
{
  "_id": ObjectId(),
  "title": "Inception",
  "type": "movie",
  "genre": ["Sci-Fi", "Action"],
  "release_year": 2010
}
```

Campos:

* `_id` → identificador del contenido
* `title` → título de la película o serie
* `type` → tipo de contenido (movie o series)
* `genre` → lista de géneros
* `release_year` → año de lanzamiento

---

## 3. ratings

Almacena las calificaciones que los usuarios dan a los contenidos.

Ejemplo de documento:

```json
{
  "_id": ObjectId(),
  "user_id": ObjectId(),
  "content_id": ObjectId(),
  "rating": 4,
  "created_at": ISODate()
}
```

Campos:

* `user_id` → referencia al usuario que calificó
* `content_id` → referencia al contenido calificado
* `rating` → puntuación dada por el usuario
* `created_at` → fecha de la calificación

Esta colección permite que **varios usuarios califiquen el mismo contenido**.

---

## 4. lists

Representa las listas creadas por los usuarios para guardar contenido.

Ejemplo de documento:

```json
{
  "_id": ObjectId(),
  "user_id": ObjectId(),
  "name": "Ver luego",
  "created_at": ISODate()
}
```

Campos:

* `user_id` → usuario dueño de la lista
* `name` → nombre de la lista
* `created_at` → fecha de creación

En este proyecto se utiliza principalmente la lista **"Ver luego"**, aunque el modelo permite agregar múltiples listas por usuario en el futuro.

---

## 5. list_items

Almacena los contenidos que pertenecen a cada lista.

Ejemplo de documento:

```json
{
  "_id": ObjectId(),
  "list_id": ObjectId(),
  "content_id": ObjectId(),
  "added_at": ISODate()
}
```

Campos:

* `list_id` → referencia a la lista
* `content_id` → referencia al contenido
* `added_at` → fecha en la que se agregó el contenido

Este diseño evita guardar grandes arreglos dentro de un documento y permite **manejar listas con muchos elementos de forma eficiente**.

---

# Consultas de Agregación

El proyecto incluye consultas de agregación para obtener información útil a partir de los datos.

---

## Promedio de calificación por contenido

Calcula el promedio de calificaciones de cada contenido.

Pipeline:

```javascript
[
  {
    $group: {
      _id: "$content_id",
      average_rating: { $avg: "$rating" },
      total_ratings: { $sum: 1 }
    }
  },
  {
    $lookup: {
      from: "content",
      localField: "_id",
      foreignField: "_id",
      as: "content_info"
    }
  },
  { $unwind: "$content_info" },
  {
    $project: {
      _id: 0,
      title: "$content_info.title",
      average_rating: 1,
      total_ratings: 1
    }
  }
]
```

Esta agregación permite ver **el promedio de puntuación y el número de calificaciones por contenido**.

---

## Contenido más guardado en "Ver luego"

Muestra qué contenido aparece con mayor frecuencia en las listas de los usuarios.

Pipeline:

```javascript
[
  {
    $group: {
      _id: "$content_id",
      times_added: { $sum: 1 }
    }
  },
  { $sort: { times_added: -1 } },
  {
    $lookup: {
      from: "content",
      localField: "_id",
      foreignField: "_id",
      as: "content_info"
    }
  },
  { $unwind: "$content_info" },
  {
    $project: {
      _id: 0,
      title: "$content_info.title",
      times_added: 1
    }
  }
]
```

Esta consulta permite identificar **qué contenido es más popular entre los usuarios**.

---

## Contenido guardado por cada usuario

Muestra qué contenidos tiene guardados cada usuario en su lista.

Pipeline:

```javascript
[
  {
    $lookup: {
      from: "lists",
      localField: "list_id",
      foreignField: "_id",
      as: "list"
    }
  },
  { $unwind: "$list" },
  {
    $lookup: {
      from: "users",
      localField: "list.user_id",
      foreignField: "_id",
      as: "user"
    }
  },
  { $unwind: "$user" },
  {
    $lookup: {
      from: "content",
      localField: "content_id",
      foreignField: "_id",
      as: "content"
    }
  },
  { $unwind: "$content" },
  {
    $project: {
      _id: 0,
      user: "$user.name",
      saved_content: "$content.title"
    }
  }
]
```

Esta agregación conecta **usuarios, listas y contenido** para mostrar qué contenido tiene guardado cada usuario.

---

# Consideraciones de Diseño

* Se utilizan **referencias entre colecciones** en lugar de grandes arreglos embebidos.
* El modelo permite **escalar listas con muchos elementos** sin afectar el rendimiento.
* Las agregaciones permiten generar **estadísticas y análisis del contenido**.
* La estructura permite agregar nuevas funcionalidades en el futuro, como:

  * múltiples listas por usuario
  * sistemas de recomendación
  * historial de visualización

---

# Tecnologías Utilizadas

* MongoDB
* MongoDB Compass
* Aggregation Pipeline
