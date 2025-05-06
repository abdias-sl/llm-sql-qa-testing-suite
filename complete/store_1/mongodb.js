// MongoDB Creation Script
// Connect to database (adjust connection string as needed)
// mongo "mongodb://localhost:27017/musicdb"

// Drop existing collections if they exist
db.artists.drop();
db.albums.drop();
db.employees.drop();
db.customers.drop();
db.genres.drop();
db.invoices.drop();
db.invoice_lines.drop();
db.media_types.drop();
db.playlists.drop();
db.tracks.drop();

// Create collections with validators
db.createCollection("artists", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name"],
      properties: {
        name: { bsonType: "string", maxLength: 120 }
      }
    }
  }
});

db.createCollection("albums", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["title", "artist_id"],
      properties: {
        title: { bsonType: "string", maxLength: 160 },
        artist_id: { bsonType: "objectId" }
      }
    }
  }
});

db.createCollection("employees", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["last_name", "first_name"],
      properties: {
        last_name: { bsonType: "string", maxLength: 20 },
        first_name: { bsonType: "string", maxLength: 20 },
        title: { bsonType: ["string", "null"], maxLength: 30 },
        reports_to: { bsonType: ["objectId", "null"] },
        birth_date: { bsonType: ["date", "null"] },
        hire_date: { bsonType: ["date", "null"] },
        address: { bsonType: ["string", "null"], maxLength: 70 },
        city: { bsonType: ["string", "null"], maxLength: 40 },
        state: { bsonType: ["string", "null"], maxLength: 40 },
        country: { bsonType: ["string", "null"], maxLength: 40 },
        postal_code: { bsonType: ["string", "null"], maxLength: 10 },
        phone: { bsonType: ["string", "null"], maxLength: 24 },
        fax: { bsonType: ["string", "null"], maxLength: 24 },
        email: { bsonType: ["string", "null"], maxLength: 60 }
      }
    }
  }
});

db.createCollection("customers", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["first_name", "last_name", "email"],
      properties: {
        first_name: { bsonType: "string", maxLength: 40 },
        last_name: { bsonType: "string", maxLength: 20 },
        company: { bsonType: ["string", "null"], maxLength: 80 },
        address: { bsonType: ["string", "null"], maxLength: 70 },
        city: { bsonType: ["string", "null"], maxLength: 40 },
        state: { bsonType: ["string", "null"], maxLength: 40 },
        country: { bsonType: ["string", "null"], maxLength: 40 },
        postal_code: { bsonType: ["string", "null"], maxLength: 10 },
        phone: { bsonType: ["string", "null"], maxLength: 24 },
        fax: { bsonType: ["string", "null"], maxLength: 24 },
        email: { bsonType: "string", maxLength: 60 },
        support_rep_id: { bsonType: ["objectId", "null"] }
      }
    }
  }
});

db.createCollection("genres", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name"],
      properties: {
        name: { bsonType: "string", maxLength: 120 }
      }
    }
  }
});

db.createCollection("media_types", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name"],
      properties: {
        name: { bsonType: "string", maxLength: 120 }
      }
    }
  }
});

db.createCollection("tracks", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "media_type_id", "milliseconds", "unit_price"],
      properties: {
        name: { bsonType: "string", maxLength: 200 },
        album_id: { bsonType: ["objectId", "null"] },
        media_type_id: { bsonType: "objectId" },
        genre_id: { bsonType: ["objectId", "null"] },
        composer: { bsonType: ["string", "null"], maxLength: 220 },
        milliseconds: { bsonType: "int" },
        bytes: { bsonType: ["int", "null"] },
        unit_price: { bsonType: "decimal" }
      }
    }
  }
});

db.createCollection("invoices", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["customer_id", "invoice_date", "total"],
      properties: {
        customer_id: { bsonType: "objectId" },
        invoice_date: { bsonType: "date" },
        billing_address: { bsonType: ["string", "null"], maxLength: 70 },
        billing_city: { bsonType: ["string", "null"], maxLength: 40 },
        billing_state: { bsonType: ["string", "null"], maxLength: 40 },
        billing_country: { bsonType: ["string", "null"], maxLength: 40 },
        billing_postal_code: { bsonType: ["string", "null"], maxLength: 10 },
        total: { bsonType: "decimal" }
      }
    }
  }
});

db.createCollection("invoice_lines", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["invoice_id", "track_id", "unit_price", "quantity"],
      properties: {
        invoice_id: { bsonType: "objectId" },
        track_id: { bsonType: "objectId" },
        unit_price: { bsonType: "decimal" },
        quantity: { bsonType: "int" }
      }
    }
  }
});

db.createCollection("playlists", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name"],
      properties: {
        name: { bsonType: "string", maxLength: 120 }
      }
    }
  }
});

db.createCollection("playlist_tracks", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["playlist_id", "track_id"],
      properties: {
        playlist_id: { bsonType: "objectId" },
        track_id: { bsonType: "objectId" }
      }
    }
  }
});

// Create indexes
db.albums.createIndex({ "artist_id": 1 });
db.customers.createIndex({ "support_rep_id": 1 });
db.employees.createIndex({ "reports_to": 1 });
db.invoices.createIndex({ "customer_id": 1 });
db.invoice_lines.createIndex({ "invoice_id": 1 });
db.invoice_lines.createIndex({ "track_id": 1 });
db.playlist_tracks.createIndex({ "track_id": 1 });
db.playlist_tracks.createIndex({ "playlist_id": 1, "track_id": 1 }, { unique: true });
db.tracks.createIndex({ "album_id": 1 });
db.tracks.createIndex({ "genre_id": 1 });
db.tracks.createIndex({ "media_type_id": 1 });

// Alternative approach: An example of embedding related documents
// This shows how you might model playlists with embedded tracks instead of using references
/*
db.createCollection("playlists_embedded", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "tracks"],
      properties: {
        name: { bsonType: "string", maxLength: 120 },
        tracks: {
          bsonType: "array",
          items: {
            bsonType: "object",
            required: ["track_id"],
            properties: {
              track_id: { bsonType: "objectId" }
            }
          }
        }
      }
    }
  }
});
*/


/* INSERTIONS */
// MongoDB Insert Commands

// Insert into genres
db.genres.insertOne({
  _id: ObjectId(),
  name: "Rock"
});

// Insert into media_types
db.media_types.insertOne({
  _id: ObjectId(),
  name: "MPEG audio file"
});

// Insert into artists
const artistId = ObjectId();
db.artists.insertOne({
  _id: artistId,
  name: "AC/DC"
});

// Insert into albums
const albumId = ObjectId();
db.albums.insertOne({
  _id: albumId,
  title: "For Those About To Rock We Salute You",
  artist_id: artistId
});

// Insert into tracks
const genreId = db.genres.findOne({ name: "Rock" })._id;
const mediaTypeId = db.media_types.findOne({ name: "MPEG audio file" })._id;
const trackId = ObjectId();

db.tracks.insertOne({
  _id: trackId,
  name: "For Those About To Rock (We Salute You)",
  album_id: albumId,
  media_type_id: mediaTypeId,
  genre_id: genreId,
  composer: "Angus Young, Malcolm Young, Brian Johnson",
  milliseconds: 343719,
  bytes: 11170334,
  unit_price: NumberDecimal("0.99")
});

// Insert into employees
const employeeId = ObjectId();
db.employees.insertOne({
  _id: employeeId,
  last_name: "Adams",
  first_name: "Andrew",
  title: "General Manager",
  birth_date: new Date("1962-02-18"),
  hire_date: new Date("2002-08-14"),
  address: "11120 Jasper Ave NW",
  city: "Edmonton",
  state: "AB",
  country: "Canada",
  postal_code: "T5K 2N1",
  phone: "+1 (780) 428-9482",
  fax: "+1 (780) 428-3457",
  email: "andrew@chinookcorp.com"
});

// Insert into customers
// First, find the support rep by ID (assuming rep with ID 3 exists)
const supportRepId = db.employees.find().skip(2).limit(1).next()._id;  // This simulates getting employee with ID 3

db.customers.insertOne({
  _id: ObjectId(),
  first_name: "Luís",
  last_name: "Gonçalves",
  company: "Embraer - Empresa Brasileira de Aeronáutica S.A.",
  address: "Av. Brigadeiro Faria Lima, 2170",
  city: "São José dos Campos",
  state: "SP",
  country: "Brazil",
  postal_code: "12227-000",
  phone: "+55 (12) 3923-5555",
  fax: "+55 (12) 3923-5566",
  email: "luisg@embraer.com.br",
  support_rep_id: supportRepId
});

// Insert into invoices
// First, find the customer with ID 2
const customerId = db.customers.find().skip(1).limit(1).next()._id;  // This simulates getting customer with ID 2

const invoiceId = ObjectId();
db.invoices.insertOne({
  _id: invoiceId,
  customer_id: customerId,
  invoice_date: new Date("2007-01-01"),
  billing_address: "Theodor-Heuss-Straße 34",
  billing_city: "Stuttgart",
  billing_country: "Germany",
  billing_postal_code: "70174",
  total: NumberDecimal("1.98")
});

// Insert into invoice_lines
// First, find track with ID 2
const trackForInvoice = db.tracks.find().skip(1).limit(1).next()._id;  // This simulates getting track with ID 2

db.invoice_lines.insertOne({
  _id: ObjectId(),
  invoice_id: invoiceId,
  track_id: trackForInvoice,
  unit_price: NumberDecimal("0.99"),
  quantity: 1
});

// Insert into playlists
const playlistId = ObjectId();
db.playlists.insertOne({
  _id: playlistId,
  name: "Music"
});

// Insert into playlist_tracks
// Find track with ID 3402
// Note: In a real scenario, you would need to have this track already inserted
// This is just a placeholder assuming track 3402 exists
const trackForPlaylist = ObjectId();  // In reality, you would query for the specific track

db.playlist_tracks.insertOne({
  _id: ObjectId(),
  playlist_id: playlistId,
  track_id: trackForPlaylist
});

// Alternative approach with an array of operations
// This shows how you could batch multiple inserts together
const operations = [
  { insertOne: { document: { name: "Jazz" } } },
  { insertOne: { document: { name: "Blues" } } }
];

db.genres.bulkWrite(operations);

// Example of insertMany for multiple documents at once
db.artists.insertMany([
  { name: "Accept" },
  { name: "Aerosmith" },
  { name: "Alanis Morissette" },
  { name: "Alice In Chains" }
]);
