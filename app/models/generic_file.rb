class GenericFile < ActiveFedora::Base
  include Sufia::GenericFile

  property :production_id, predicate: ::RDF::URI('http://docs.osfashland.org/terms/production_id'), multiple: false

  property :production_name, predicate: ::RDF::URI('http://docs.osfashland.org/terms/production_name'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :venue_id, predicate: ::RDF::URI('http://docs.osfashland.org/terms/venue_id'), multiple: false

  property :venue_name, predicate: ::RDF::URI('http://docs.osfashland.org/terms/venue_name'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :work_id, predicate: ::RDF::URI('http://docs.osfashland.org/terms/work_id'), multiple: false

  property :work_name, predicate: ::RDF::URI('http://docs.osfashland.org/terms/work_name'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  property :highlighted, predicate: ::RDF::URI('http://docs.osfashland.org/terms/highlighted'), multiple: false do |index|
    index.as :stored_searchable, :facetable
  end

  before_save :set_calculated_fields

  private

  def set_calculated_fields
    self.production_name = production.production_name if production
    self.venue_name = venue.name if venue
    self.work_name = work.title if work
    # self.asset_create_year = year_created if year_created
  end

  def work
    return if !work_id || work_id.empty? || work_id.first.nil?
    ProductionCredits::Work.find(work_id)
  end

  def production
    return if !production_id || production_id.empty? || production_id.first.nil?
    ProductionCredits::Production.find(production_id)
  end

  def venue
    if venue_id && !venue_id.empty? && !venue_id.first.nil?
      venue = ProductionCredits::Venue.find(venue_id)
    end

    if !venue && production
      venue = production.venue
    end
    venue
  end
end
