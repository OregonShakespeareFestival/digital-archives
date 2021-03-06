require "solrizer"

class FileSearch
  attr_reader :current_page, :total_pages, :next_page, :total_items, :per_page

  def initialize(params, options = {})
    @params = params
    @per_page = options[:per_page] || 10
    @resource_type = options[:resource_type].to_s
    @catalog_query = options[:catalog_query]
    @file_query = options[:file_query] || GenericFile
  end

  def self.all_years
    1935..Date.today.year
  end

  def all_works
    @all_works ||= ProductionCredits::Work.order(:title)
  end

  def all_venue_names
    @all_venue_names ||= hardcoded_venues
  end

  def all_resource_types
    @all_resource_types ||= RESOURCE_TYPES
  end

  def all_years
    self.class.all_years
  end

  def search_term
    params[:q]
  end

  def page
    params[:page]
  end

  def work_name
    params[:work]
  end

  def venue_names
    params.fetch(:venues) { all_venue_names }
  end

  def resource_types
    Array(resource_type)
  end

  def types
    params.fetch(:types) { all_resource_types }
  end

  def show?
    types.include?(resource_type.pluralize)
  end

  def year_range
    raw = params.fetch(:years) { "" }
    from, to = raw.split(";").map(&method(:Integer))
    return all_years unless from && to
    from..to
  rescue ArgumentError
    all_years
  end

  def result
    if show?
      (response, documents) = catalog_query.search_results(search_query, catalog_query.search_params_logic)
      SearchResults.new(response, file_query.find(documents.map(&:id)))
    else
      SearchResults.empty
    end
  end

  PRIMARY_VENUES = {
    "Elizabethan" => "Elizabethan Theatre",
    "Angus Bowmer" => "Angus Bowmer Theatre",
    "Thomas" => "Thomas Theatre",
    "Courtyard" => "Courtyard"
  }
  OTHER_VENUE = "Other"
  RESOURCE_TYPES = %w[images videos audios articles]

  private

  attr_reader :params, :catalog_query, :file_query, :resource_type

  def search_query
    query = {}
    query[:q] = search_term if search_term
    query[:f] = filters unless filters.empty?
    query[:page] = page if page
    query[:per_page] = per_page
    query
  end

  def has_query_params?
    (params.stringify_keys.keys & %w(q work venues years types)).any?
  end

  def hardcoded_venues
    PRIMARY_VENUES.keys + [OTHER_VENUE]
  end

  def filters
    {}
      .merge(work_filter)
      .merge(venue_filter)
      .merge(year_filter)
      .merge(resource_type_filter)
      .merge(curated_filter)
  end

  def curated_filter
    # 'curated' is only used on first view of index
    return {} if has_query_params?
    { Solrizer.solr_name("curated", :facetable) => "1" }
  end

  def resource_type_filter
    return {} if resource_types.empty? || resource_types == all_resource_types
    types = resource_types.map { |type| type.singularize.capitalize }
    { Solrizer.solr_name("resource_type", :facetable) => types }
  end

  def work_filter
    return {} unless work_name
    { Solrizer.solr_name("work_names", :facetable) => work_name }
  end

  def venue_filter
    return {} if venue_names.empty? || venue_names == all_venue_names
    if venue_names.include?(OTHER_VENUE)
      {
        Solrizer.solr_name("!venue_names", :facetable) =>
          (PRIMARY_VENUES.keys - venue_names).map(&method(:db_venue_name))
      }
    else
      {
        Solrizer.solr_name("venue_names", :facetable) =>
          venue_names.map(&method(:db_venue_name))
      }
    end
  end

  def db_venue_name(venue_name)
    PRIMARY_VENUES.fetch(venue_name) { venue_name }
  end

  def year_filter
    return {} if year_range == all_years
    { Solrizer.solr_name(
      "year_created", :stored_sortable, type: :integer
      ) => year_range }
  end
end
