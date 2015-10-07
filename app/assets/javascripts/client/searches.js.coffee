@App ?= {}

class @App.Searches
  constructor: ->
    fetchesResults = new App.FetchesResults
    resultsSections =
      articles: new App.ResultsSection("articles", fetchesResults)
      audios: new App.ResultsSection("audios", fetchesResults)
      images: new App.ImageResultsSection("images", fetchesResults)
      videos: new App.VideoResultsSection("videos", fetchesResults)
    new App.FilterSection(resultsSections, fetchesResults)

$ ->
  new App.Searches
