austen = Author.create(name: "Jane Austen")
pratchett = Author.create(name: "Terry Pratchett")
gaiman = Author.create(name: "Neil Gaiman")
kingsolver = Author.create(name: "Barbara Kingsolver")

pride_and_prejudice = Book.create!(title: "Pride and Prejudice", year: 1813, length: 432, authors: [austen], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51sOyMmEYBL._SX310_BO1,204,203,200_.jpg")
good_omens = Book.create!(title: "Good Omens", year: 1990, length: 288, authors: [pratchett, gaiman], cover_image: "https://images-na.ssl-images-amazon.com/images/I/81Ig%2Br7RTKL.jpg")
sense_and_sensibility = Book.create!(title: "Sense and Sensibility", year: 1811, length: 352, authors: [austen], cover_image: "https://images.gr-assets.com/books/1176166955l/600331.jpg")
poisonwood_bible = Book.create!(title: "The Poisonwood Bible", year: 1998, length: 546, authors: [kingsolver], cover_image: "https://i.pinimg.com/236x/85/8f/8e/858f8e3a58b6cde30f804495a7a70b0f--barbara-kingsolver-bible.jpg")

 
