require "rails_helper"

RSpec.describe Book, type: :request do
    describe "POST /books" do
        context "sunny day - valid title" do
            let(:valid_names) do
                { book: { title: "The Fountainhead", author: "Ayn Rand",
                        price: 19.99, published_date: Date.new(1943, 5, 1) } }
        end

        it "save book to database and redirects to index page" do
            expect {
                post books_path, params: valid_names
        }.to change(Book, :count).by(1)
        end

        it "sets the correct flash notice" do
            post books_path, params: valid_names
            expect(flash[:notice]).to eq("Book was successfully created.")
        end

        it "displays the correct book details on the index page" do
            post books_path, params: valid_names
            follow_redirect!
            expect(response.body).to include("Book was successfully created.")
        end
        end

    context "rainy day - invalid missing author" do
        let(:invalid_author) do
            { book: { title: "The Fountainhead", author: "",
            price: 19.99, published_date: Date.new(1943, 5, 1) } }
        end

        it "does not save the book to the database" do
            expect {
                post books_path, params: invalid_author
            }.not_to change(Book, :count)
        end

        it "sets error messages" do
            post books_path, params: invalid_author
            expect(flash[:alert]).to eq("Book could not be created.")
        end
        it "displays error messages on the new page" do
        post books_path, params: invalid_author
        expect(response).to have_http_status(422)
        expect(response.body).to include("Book could not be created.")
    end
    end

    context "rainy day - invalid price" do
        let(:invalid_price) do
            { book: { title: "The Fountainhead", author: "Ayn Rand", price: -10.00, published_date: Date.new(1943, 5, 1) } }
        end

        it "does not save the book to the database" do
            expect {
                post books_path, params: invalid_price
            }.not_to change(Book, :count)
        end

        it "sets error messages" do
            post books_path, params: invalid_price
            expect(flash[:alert]).to eq("Book could not be created.")
        end
        it "displays error messages on the new page" do
        post books_path, params: invalid_price
        expect(response).to have_http_status(422)
        expect(response.body).to include("Book could not be created.")
    end
    end

    context "rainy day - invalid date" do
        let(:invalid_date) do
            { book: { title: "The Fountainhead", author: "Ayn Rand", price: -10.00, published_date: nil } }
        end

        it "does not save the book to the database" do
            expect {
                post books_path, params: invalid_date
            }.not_to change(Book, :count)
        end

        it "sets error messages" do
            post books_path, params: invalid_date
            expect(flash[:alert]).to eq("Book could not be created.")
        end

        it "displays error messages on the new page" do
        post books_path, params: invalid_date
        expect(response).to have_http_status(422)
        expect(response.body).to include("Book could not be created.")
    end
    end

    context "rainy day - invalid title" do
        let(:invalid_title) do
            { book: { title: "", author: "Ayn Rand",
            price: 19.99, published_date: Date.new(1943, 5, 1) } }
        end

    it "does not save the book to the database" do
        expect {
            post books_path, params: invalid_title
        }.not_to change(Book, :count)
    end

    it "sets error messages" do
        post books_path, params: invalid_title
        expect(flash[:alert]).to eq("Book could not be created.")
    end

    it "displays error messages on the new page" do
        post books_path, params: invalid_title
        expect(response).to have_http_status(422)
        expect(response.body).to include("Book could not be created.")
    end
end
end
end
