require 'rails_helper'

describe GenericFilesController do
  routes { Sufia::Engine.routes }
  let(:user) { FactoryGirl.find_or_create(:user) }
  let(:generic_file) do
    GenericFile.create do |gf|
      gf.apply_depositor_metadata(user)
    end
  end
  let(:production) do
    instance_double(ProductionCredits::Production,
                    id: 1,
                    production_name: "The Production",
                    work: nil)
  end
  let(:venue) { instance_double(ProductionCredits::Venue, id: 2, full_name: "The Venue", all_names: ["The Venue"]) }
  let(:event_type) { instance_double(ProductionCredits::EventType, id: 3, name: "The Event") }
  let(:attributes) do
    {
      production_ids: [production.id],
      venue_ids: [venue.id],
      event_type_id: event_type.id
    }
  end
  let(:reloaded) { generic_file.reload }

  before do
    allow(ProductionCredits::Production).to receive(:find)
      .with([production.id.to_s]) { [production] }
    allow(ProductionCredits::Production).to receive(:find).with([]) { [] }
    allow(ProductionCredits::Venue).to receive(:find).with([venue.id.to_s]) { [venue] }
    allow(ProductionCredits::Venue).to receive(:find).with([]) { [] }
    allow(ProductionCredits::EventType).to receive(:find).with(event_type.id.to_s) { event_type }
    sign_in user
    post :update, id: generic_file, generic_file: attributes
  end

  it "persists the ids" do
    expect(reloaded.production_ids).to eq [production.id.to_s]
    expect(reloaded.venue_ids).to eq [venue.id.to_s]
    expect(reloaded.event_type_id).to eq event_type.id.to_s
  end

  it "finds and persists the names" do
    expect(reloaded.production_names).to eq [production.production_name]
    expect(reloaded.venue_names).to eq venue.all_names
    expect(reloaded.venue_full_names).to eq [venue.full_name]
    expect(reloaded.event_type_name).to eq event_type.name
  end
end
