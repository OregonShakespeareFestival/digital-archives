require "rails_helper"

module Observers
  RSpec.describe ProductionObserver do
    let(:queue) { Sufia.queue }

    before do
      allow(queue).to receive(:push)
    end

    context "when modifying a production" do
      let(:work) { create_production("OLD") }

      context "when editing the production name" do
        before do
          work.update_attributes(production_name: "NEW")
        end

        it "queues an update job" do
          expect(queue).to have_received(:push).with(UpdateGenericFileJob)
        end
      end

      context "when editing any other attribute" do
        before do
          work.update_attributes(category: "CATEGORY")
        end

        it "does not queue an update job" do
          expect(queue).not_to have_received(:push)
        end
      end
    end

    context "when creating a new work" do
      before do
        create_production("NEW")
      end

      it "does not queue an update job" do
        expect(queue).not_to have_received(:push)
      end
    end

    def create_production(name)
      FactoryGirl.create(:production_credits_production, production_name: name)
    end
  end
end
