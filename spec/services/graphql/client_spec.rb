require 'rails_helper'

RSpec.describe Graphql::Client do
  describe '#query', :vcr do
    let(:owner) { 'github' }
    let(:repo) { 'graphql-client' }

    context 'success case' do
      let!(:response) { described_class.query(Graphql::Queries::Repo, variables: {owner: owner, repo_name: repo}) }

      it 'should get success response' do
        expect(response.success?).to be_truthy
      end

      it 'should fetch information of repository from github' do
        expect(response.json_data['data']['repository']['name']).to eq repo
      end
    end

    context 'failed case' do
      it 'should raise exception if repository not found' do
        expect { described_class.query(Graphql::Queries::Repo, variables: {owner: owner, repo_name: 'not-exist-repo'}) }.to raise_error(GraphqlRequestError, %q(Could not resolve to a Repository with the name 'github/not-exist-repo'.))
      end
    end

    context 'access token not set properly' do
      it 'will raise exception if access token not set' do
        ENV['GITHUB_ACCESS_KEY'] = nil
        expect { described_class.query(Graphql::Queries::Repo, variables: {owner: owner, repo_name: repo}) }.to raise_error(GraphqlMissingKeyError, "Missing Github access token")
      end

      it 'will raise exception if access token is not valid' do
        ENV['GITHUB_ACCESS_KEY'] = 'some-error-key'
        
        expect { described_class.query(Graphql::Queries::Repo, variables: {owner: owner, repo_name: repo}) }.to raise_error(GraphqlRequestError)
      end
    end
  end
end
