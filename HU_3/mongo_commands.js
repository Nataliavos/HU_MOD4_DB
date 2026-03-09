// ========================================
// DATABASE
// ========================================

use("streamhub")

// ========================================
// COLLECTIONS
// ========================================

db.createCollection("users")
db.createCollection("content")
db.createCollection("ratings")
db.createCollection("lists")
db.createCollection("list_items")


// ========================================
// INSERTS
// ========================================

// content
db.content.insertMany([
  { title: "Inception", type: "movie", genres: ["Sci-Fi","Thriller"], durationMin: 148, year: 2010, metrics: { views: 120 } },

  { title: "Whiplash", type: "movie", genres: ["Drama","Music"], durationMin: 107, year: 2014, metrics: { views: 65 } },

  { title: "Spirited Away", type: "movie", genres: ["Animation","Fantasy"], durationMin: 125, year: 2001, metrics: { views: 90 } },

  { title: "The Social Network", type: "movie", genres: ["Drama"], durationMin: 120, year: 2010, metrics: { views: 40 } },

  { title: "Dune", type: "movie", genres: ["Sci-Fi","Adventure"], durationMin: 155, year: 2021, metrics: { views: 150 } },

  { title: "Stranger Things", type: "series", genres: ["Sci-Fi","Horror"], seasons: 4, year: 2016, metrics: { views: 300 } },

  { title: "Dark", type: "series", genres: ["Sci-Fi","Mystery"], seasons: 3, year: 2017, metrics: { views: 180 } },

  { title: "Chernobyl", type: "series", genres: ["Drama","History"], seasons: 1, year: 2019, metrics: { views: 110 } }
])


// users
db.users.insertOne({
  name: "Natalia Gomez",
  email: "natalia@streamhub.com",
  stats: { watchedCount: 7 },
  createdAt: ISODate("2026-02-01T00:00:00Z")
})

db.users.insertOne({
  name: "Andres Ruiz",
  email: "andres@streamhub.com",
  stats: { watchedCount: 3 },
  createdAt: ISODate("2026-02-05T00:00:00Z")
})

db.users.insertOne({
  name: "Laura Martinez",
  email: "laura@streamhub.com",
  stats: { watchedCount: 9 },
  createdAt: ISODate("2026-02-10T00:00:00Z")
})

db.users.insertOne({
  name: "Carlos Vega",
  email: "carlos@streamhub.com",
  stats: { watchedCount: 2 },
  createdAt: ISODate("2026-02-15T00:00:00Z")
})


// ========================================
// LISTS (watch later)
// ========================================

const users = db.users.find().toArray()

users.forEach(user => {
  db.lists.insertOne({
    userId: user._id,
    name: "Ver luego",
    type: "watch_later",
    createdAt: new Date(),
    updatedAt: new Date()
  })
})


// ========================================
// LIST ITEMS
// ========================================

const contents = db.content.find().toArray()
const lists = db.lists.find().toArray()

db.list_items.insertMany([
  {
    listId: lists[0]._id,
    userId: lists[0].userId,
    contentId: contents[0]._id,
    addedAt: new Date(),
    state: "active"
  },
  {
    listId: lists[0]._id,
    userId: lists[0].userId,
    contentId: contents[4]._id,
    addedAt: new Date(),
    state: "active"
  },
  {
    listId: lists[1]._id,
    userId: lists[1].userId,
    contentId: contents[2]._id,
    addedAt: new Date(),
    state: "active"
  },
  {
    listId: lists[2]._id,
    userId: lists[2].userId,
    contentId: contents[5]._id,
    addedAt: new Date(),
    state: "active"
  }
])


// ========================================
// RATINGS
// ========================================

db.ratings.insertMany([
  { userId: users[0]._id, contentId: contents[0]._id, score: 5, review: "Excelente pelicula", createdAt: new Date() },
  { userId: users[1]._id, contentId: contents[0]._id, score: 4, review: "Muy buena", createdAt: new Date() },
  { userId: users[2]._id, contentId: contents[0]._id, score: 5, review: "Obra maestra", createdAt: new Date() },

  { userId: users[0]._id, contentId: contents[4]._id, score: 4, review: "Gran ciencia ficcion", createdAt: new Date() },
  { userId: users[1]._id, contentId: contents[4]._id, score: 5, review: "Increible", createdAt: new Date() },

  { userId: users[2]._id, contentId: contents[1]._id, score: 5, review: "Actuaciones brutales", createdAt: new Date() },

  { userId: users[3]._id, contentId: contents[2]._id, score: 4, review: "Muy bonita animacion", createdAt: new Date() },

  { userId: users[0]._id, contentId: contents[6]._id, score: 5, review: "Serie excelente", createdAt: new Date() }
])


// ========================================
// QUERIES (OPERATORS)
// ========================================

// peliculas con duracion mayor a 120
db.content.find({
  type: "movie",
  durationMin: { $gt: 120 }
})


// usuarios que vieron mas de 5 contenidos
db.users.find({
  "stats.watchedCount": { $gt: 5 }
})


// generos con $in
db.content.find({
  genres: { $in: ["Drama", "Sci-Fi"] }
})


// uso de $and
db.content.find({
  $and: [
    { type: "movie" },
    { durationMin: { $lt: 130 } }
  ]
})


// uso de $or
db.content.find({
  $or: [
    { year: { $gte: 2020 } },
    { "metrics.views": { $gt: 100 } }
  ]
})


// uso de regex
db.ratings.find({
  review: { $regex: "excelente", $options: "i" }
})


// ========================================
// UPDATES
// ========================================

// updateOne
db.ratings.updateOne(
  { score: 4 },
  { $set: { score: 5 } }
)


// updateMany
db.content.updateMany(
  { type: "movie" },
  { $inc: { "metrics.views": 10 } }
)


// ========================================
// DELETES
// ========================================

// deleteOne
db.ratings.deleteOne({
  score: 1
})


// deleteMany
db.ratings.deleteMany({
  review: { $exists: false }
})


// ========================================
// INDEXES
// ========================================

// users
db.users.createIndex({ email: 1 }, { unique: true })
db.users.createIndex({ "stats.watchedCount": 1 })

// content
db.content.createIndex({ title: 1 })
db.content.createIndex({ type: 1, durationMin: 1 })

// ratings
db.ratings.createIndex({ userId: 1, contentId: 1 })

// lists
db.lists.createIndex({ userId: 1 }, { unique: true })

// list_items
db.list_items.createIndex({ listId: 1, contentId: 1 }, { unique: true })


// ========================================
// AGGREGATIONS
// ========================================

// promedio de rating por contenido
db.ratings.aggregate([
  {
    $group: {
      _id: "$contentId",
      avgScore: { $avg: "$score" },
      countRatings: { $sum: 1 }
    }
  },
  { $sort: { avgScore: -1 } }
])


// top generos mas vistos
db.content.aggregate([
  { $unwind: "$genres" },
  {
    $group: {
      _id: "$genres",
      totalViews: { $sum: "$metrics.views" }
    }
  },
  { $sort: { totalViews: -1 } }
])


// contenidos guardados en listas
db.list_items.aggregate([
  {
    $group: {
      _id: "$contentId",
      saves: { $sum: 1 }
    }
  },
  { $sort: { saves: -1 } }
])