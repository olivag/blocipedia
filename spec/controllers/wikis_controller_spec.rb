require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { create(:wiki) }
  let(:my_user) { create(:user) }

  describe "GET #index" do
    before { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe "GET #show" do
    before { get :show, id: my_wiki.id }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      expect(response).to render_template(:show)
    end

    it "assigns my_wiki to @wiki" do
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET #new" do
    before { get :new }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      expect(response).to render_template(:new)
    end

    it "instantiates @wiki" do
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST create" do
    before { sign_in(:my_user) }
    
    it "increases the numbers of Wikis by 1" do
      expect{post :create, wiki: {tittle: "My title", body: "My body"}}.to change(Wiki, :count).by(1)
    end

    it "assigns the new wiki to @wiki" do
      post :create, wiki: {title: "My title", body: "My body"}
      expect(assigns(:wiki)).to eq(Wiki.last)
    end

    it "redirects to the new wiki" do
      post :create, wiki: {title: "My title", body: "My body"}
      expect(response).to redirect_to(Wiki.last)
    end
  end

  describe "GET #edit" do
    before { get :edit, id: my_wiki.id }
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      expect(response).to render_template(:edit)
    end

    it "assigns wiki to be updated to @wiki" do
      wiki_instance = assigns(:wiki)
      expect(wiki_instance.id).to eq(my_wiki.id)
      expect(wiki_instance.title).to eq(my_wiki.title)
      expect(wiki_instance.body).to eq(my_wiki.body)
      expect(wiki_instance.private).to eq(my_wiki.private)
    end
  end
end