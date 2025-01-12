#!/usr/bin/env python
# First, import the sqlite3 module
import sqlite3
# Connect to an sqlite database
conn = sqlite3.connect('my.db')
cursor = conn.cursor()

# Create the documents table
cursor.execute('''DROP TABLE IF EXISTS documents;''')
# Create the documents table
cursor.execute('''CREATE TABLE IF NOT EXISTS documents(
                    id INTEGER PRIMARY KEY,
                    title VARCHAR(255) NOT NULL,
                    data BLOB NOT NULL
                );''')

# Insert binary data
with open('image.jpg', 'rb') as file:
    image_data = file.read()
    cursor.execute("INSERT INTO documents (title, data) VALUES (?,?)", ('JPG Image',image_data,))

# Retrieve binary data
cursor.execute("SELECT data FROM documents WHERE id = 1")
data = cursor.fetchone()[0]
# Sixth, write the BLOB data into an image file with the name stored_image.jpg:
with open('stored_image.jpg', 'wb') as file:
    file.write(data)

# Commit changes and close the database connection
conn.commit()
conn.close()
