require 'rails_helper'

RSpec.describe "Repositories", type: :request do
  describe "POST /repositories", :vcr do
    context 'all new record' do
      let(:attributes) { RepositoryFormBuilder.new(owner: 'github', repo: 'graphql-client', technology_name: 'ruby', category_name: 'login').attributes }

      subject { post '/repositories', params: {repository: attributes} }

      it "create a repository" do
        expect{ subject }.to change{ Repository.count }.by(1)
        expect(Repository.last.name).to eq 'graphql-client'
      end

      it 'create a category' do
        expect{ subject }.to change{ Category.count }.by(1)
        expect(Category.last.name).to eq 'login'
      end

      it 'create a technology' do
        expect{ subject }.to change{ Technology.count }.by(1)
        expect(Technology.last.name).to eq 'ruby'
      end

      it 'redirect to repository index page' do
        expect(subject).to redirect_to("/repositories/#{assigns(:repository).id}")
      end
    end

    context 'repo not found' do
      let(:attributes) { RepositoryFormBuilder.new(owner: 'github', repo: 'fake-repo', technology_name: 'ruby', category_name: 'login').attributes }

      subject { post '/repositories', params: {repository: attributes} }

      it 'render new template' do
        subject

        expect(subject).to render_template('repositories/new')
      end

    end
  end
end
