/**
 * Example usage
 *
 * Set the database connection string
 * :let b:db = "mongodb://user:password@host/database"
 *
 * Use :DB or <c-j> to execute 1 or more lines
 * For multi line commands use a range or visual mode
 */

// <c-j> or :DB
help

db.getCollectionNames()

// vip<c-j> or :17,21DB
db.example.insertOne({
  name: "Person 1",
  age: 1,
  email: "person1@example.com",
})

db.example.find()

const arr = [];
for (let x = 2; x <= 100; x++) {
  arr.push({
    name: `Person ${x}`,
    age: x,
    email: `person${x}@example.com`,
  });
}
db.example.insertMany(arr)

db.example.find(
  { age: { $lte: 35 } },
  { name: 1, age: 1, _id: 0 }
).map((person) => [person.name, person.age])

db.example.drop()
