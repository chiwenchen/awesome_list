require 'rails_helper'

RSpec.describe "Router", type: :request do
  describe "GET /" do
    let(:technology) { Technology.create(name: 'ruby') }
    let(:category) { Category.create(name: 'login', technology: technology) }
    let!(:repository) { Repository.create(name: 'oauth', category: category) }

    context 'render technologies' do
      subject { get '/' }

      it 'render technology template' do
        expect(subject).to render_template('technologies/index')
      end
      it "shows technology's name" do
        subject
        expect(response.body).to include(technology.name)
      end
    end

    context 'render categories' do
      subject { get '/ruby' }

      it 'render category template' do
        expect(subject).to render_template('categories/index')
      end
      it "lists categories under provided technology" do
        subject
        expect(response.body).to include(category.name)
      end
    end

    context 'render repositories' do
      subject { get '/ruby/login' }

      it 'render repository template' do
        expect(subject).to render_template('repositories/index')
      end
      it "lists repositories under provided category" do
        subject
        expect(response.body).to include(repository.name)
      end
    end
  end

  describe "GET /new" do
    context 'form to create repository' do
      subject { get '/new' }

      it "render form" do
        expect(subject).to render_template('repositories/new')
      end
    end
  end
end
