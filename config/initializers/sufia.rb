Sufia.config do |config|
  config.fits_to_desc_mapping = {
    file_title: :title,
    file_author: :creator
  }

  config.max_days_between_audits = 7

  config.max_notifications_for_dashboard = 5

  # Make sure that the default choice is first in the list.  We tried several
  # ways to specify a default without success. --RC/SC
  config.cc_licenses = {
    'Attribution-NonCommercial-ShareAlike 3.0 United States' => 'http://creativecommons.org/licenses/by-nc-sa/3.0/us/',
    'Attribution-NonCommercial 3.0 United States' => 'http://creativecommons.org/licenses/by-nc/3.0/us/',
    'Attribution-NonCommercial-NoDerivs 3.0 United States' => 'http://creativecommons.org/licenses/by-nc-nd/3.0/us/',
    'Attribution 3.0 United States' => 'http://creativecommons.org/licenses/by/3.0/us/',
    'Attribution-ShareAlike 3.0 United States' => 'http://creativecommons.org/licenses/by-sa/3.0/us/',
    'Attribution-NoDerivs 3.0 United States' => 'http://creativecommons.org/licenses/by-nd/3.0/us/',
    'Public Domain Mark 1.0' => 'http://creativecommons.org/publicdomain/mark/1.0/',
    'CC0 1.0 Universal' => 'http://creativecommons.org/publicdomain/zero/1.0/',
    'All rights reserved' => 'All rights reserved'
  }

  config.cc_licenses_reverse = Hash[*config.cc_licenses.to_a.flatten.reverse]

  config.resource_types = {
    "Article" => "Article",
    "Audio" => "Audio",
    "Image" => "Image",
    "Video" => "Video",
  }

  config.resource_types_to_schema = {
    "Article" => "http://schema.org/Article",
    "Audio" => "http://schema.org/AudioObject",
    "Book" => "http://schema.org/Book",
    "Capstone Project" => "http://schema.org/CreativeWork",
    "Conference Proceeding" => "http://schema.org/ScholarlyArticle",
    "Dataset" => "http://schema.org/Dataset",
    "Dissertation" => "http://schema.org/ScholarlyArticle",
    "Image" => "http://schema.org/ImageObject",
    "Journal" => "http://schema.org/CreativeWork",
    "Map or Cartographic Material" => "http://schema.org/Map",
    "Masters Thesis" => "http://schema.org/ScholarlyArticle",
    "Part of Book" => "http://schema.org/Book",
    "Poster" => "http://schema.org/CreativeWork",
    "Presentation" => "http://schema.org/CreativeWork",
    "Project" => "http://schema.org/CreativeWork",
    "Report" => "http://schema.org/CreativeWork",
    "Research Paper" => "http://schema.org/ScholarlyArticle",
    "Software or Program Code" => "http://schema.org/Code",
    "Video" => "http://schema.org/VideoObject",
    "Other" => "http://schema.org/CreativeWork",
  }

  config.permission_levels = {
    "Choose Access"=>"none",
    "View/Download" => "read",
    "Edit" => "edit"
  }

  config.owner_permission_levels = {
    "Edit" => "edit"
  }

  config.queue = Sufia::Resque::Queue

  # Enable displaying usage statistics in the UI
  # Defaults to FALSE
  # Requires a Google Analytics id and OAuth2 keyfile.  See README for more info
  config.analytics = true

  # Specify a Google Analytics tracking ID to gather usage statistics
  config.google_analytics_id = 'UA-425914-12'

  # Specify a date you wish to start collecting Google Analytic statistics for.
  # config.analytic_start_date = DateTime.new(2014,9,10)

  # Where to store tempfiles, leave blank for the system temp directory (e.g. /tmp)
  # config.temp_file_base = '/home/developer1'

  # Specify the form of hostpath to be used in Endnote exports
  # config.persistent_hostpath = 'http://localhost/files/'

  # If you have ffmpeg installed and want to transcode audio and video uncomment this line
  config.enable_ffmpeg = true

  # Sufia uses NOIDs for files and collections instead of Fedora UUIDs
  # where NOID = 10-character string and UUID = 32-character string w/ hyphens
  config.enable_noids = true

  # Specify a different template for your repository's NOID IDs
  # config.noid_template = ".reeddeeddk"

  # Specify the prefix for Redis keys:
  # config.redis_namespace = "sufia"

  # Specify the path to the file characterization tool:
  config.fits_path = "/opt/fits/fits.sh"

  # Specify how many seconds back from the current time that we should show by default of the user's activity on the user's dashboard
  # config.activity_to_show_default_seconds_since_now = 24*60*60

  # Sufia can integrate with Zotero's Arkivo service for automatic deposit
  # of Zotero-managed research items.
  # config.arkivo_api = false

  # Specify a date you wish to start collecting Google Analytic statistics for.
  # Leaving it blank will set the start date to when ever the file was uploaded by
  # NOTE: if you have always sent analytics to GA for downloads and page views leave this commented out
  # config.analytic_start_date = DateTime.new(2014,9,10)

  # If browse-everything has been configured, load the configs.  Otherwise, set to nil.
  begin
    if defined? BrowseEverything
      config.browse_everything = BrowseEverything.config
    else
      Rails.logger.warn "BrowseEverything is not installed"
    end
  rescue Errno::ENOENT
    config.browse_everything = nil
  end

end

Date::DATE_FORMATS[:standard] = "%m/%d/%Y"
