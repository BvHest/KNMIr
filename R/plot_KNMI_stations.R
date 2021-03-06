#' @title plot KNMI measurement stations.
#'
#' @description
#' \code{plot_stations} plots a map of The Netherlands and shows the locations of the
#' KNMI measurement station and their id and name.
#'
#' @details
#' One can show the active
#' stations (active = TRUE, the default) or *all* stations (active = FALSE).
#'
#' @param active boolean to select only currently active stations. Default =
#'   TRUE.
#' @return data-frame with the id, name, url to station information and the
#'   lat/lon of the nearest KNMI-station.
#' @export
#'
plot_stations <-
  function(active = TRUE) {

    utils::data(stations)
    # map.nl <- get_map(location = c(lon=5.1, lat=52.2),
    #                source = "google",
    #                maptype = "roadmap",
    #                zoom = 7)
    # save(map.nl, file = "./data/map_Netherlands.rda")
    utils::data(map_Netherlands)

    if (active) {
      selected_stations <- stations[is.na(stations$einddatum),]
    } else {
      selected_stations <- stations
    }

    # add station labels
    selected_stations$text <- paste(selected_stations$stationID, selected_stations$plaats)

    p <-
      ggmap::ggmap(map.nl) +
      ggplot2::geom_point(mapping = ggplot2::aes(x = lon, y = lat, color = !is.na(einddatum)),
                          size = 3,
                          data = selected_stations,
                          alpha = 1,
                          na.rm = TRUE,
                          show.legend = FALSE) +
      ggplot2::geom_label(data = selected_stations,
                          ggplot2::aes(x = lon, y = lat, label = text),
                          size = 3,
                          vjust = +0.02,
                          hjust = 0)
    print(p)
  }
