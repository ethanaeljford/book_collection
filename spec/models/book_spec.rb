require "rails_helper"

RSpec.describe Book, type: :model do
    describe "validations" do
    it "is valid with valid title" do
      book = Book.new(title: "The Fountainhead", author: "Ayn Rand")
      expect(book).to be_valid
    end

    it "is not valid without a title" do
      book = Book.new(title: nil, author: "Ayn Rand")
      expect(book).not_to be_valid
    end

    it "is not valid with a blank title" do
      book = Book.new(title: "", author: "Ayn Rand")
      expect(book).not_to be_valid
    end

    it "is not valid without an author" do 
        book = Book.new(title: "The Fountainhead", author: nil)
        expect(book).not_to be_valid
    end
    
    it "is not valid with a negative price value" do   
        book = Book.new(title: "The Fountainhead", author: "Ayn Rand", price: -10.00)
            expect(book).not_to be_valid
        end
    
    it "is not valid without a published date" do
        book = Book.new(title: "The Fountainhead", author: "Ayn Rand", price: 19.99, published_date: nil)
        expect(book).not_to be_valid
    end

    

  end
  describe "attributes" do
    it "stores author, price, and published_date" do
        book = Book.new(title: "The Fountainhead", author: "Ayn Rand", price: 19.99, published_date: Date.new(1943, 5, 1))
        expect(book.author).to eq("Ayn Rand")
        expect(book.price).to eq(19.99)
        expect(book.published_date).to eq(Date.new(1943, 5, 1))

    end
  end
end