# frozen_string_literal: true

require 'spec_helper'
require_migration!

RSpec.describe UpdateImportSourcesOnApplicationSettings, feature_category: :migration do
  let(:settings) { table(:application_settings) }
  let(:import_sources_with_google) { %w[google_code github git bitbucket bitbucket_server] }
  let(:import_sources_without_google) { %w[github git bitbucket bitbucket_server] }

  describe "#up" do
    it 'removes google_code and preserves existing valid import sources' do
      settings.create!(import_sources: import_sources_with_google)

      migrate!

      expect(YAML.safe_load(ApplicationSetting.last.import_sources)).to eq(import_sources_without_google)
    end
  end
end
