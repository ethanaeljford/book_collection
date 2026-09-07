require "rails_helper"

RSpec.describe Book, type: :request do
    describe "POST /books" do
        context "sunny day - valid book creation" do
            let(:valid_params) do 
                { book: { title: "The Fountainhead", author: "Ayn Rand", 
                        price: 19.99, published_date: Date.new(1943, 5, 1) } }
        end

        it "save book to database and redirects to index page" do
            expect {
                post books_path, params: valid_params
        }.to change(Book, :count).by(1)
        end
        
        it "sets the correct flash notice" do
            post books_path, params: valid_params
            expect(flash[:notice]).to eq("Book was successfully created.")
        end

        it "displays the correct book details on the index page" do
            post books_path, params: valid_params
            follow_redirect!
            expect(response.body).to include("Book was successfully created.")
        end
        end

    context "rainy day - invalid book creation" do
        let(:invalid_params) do 
            { book: { title: "", author: "Ayn Rand", 
            price: 19.99, published_date: Date.new(1943, 5, 1) } }
        end

    it "does not save the book to the database" do
        expect {
            post books_path, params: invalid_params
        }.not_to change(Book, :count)
    end

    it "sets error messages" do
        post books_path, params: invalid_params
        expect(flash[:alert]).to eq("Book could not be created.")
    end

    it "displays error messages on the new page" do
        post books_path, params: invalid_params
        expect(response).to have_http_status(422)
        expect(response.body).to include("Book could not be created.")
    end
end
end
end