

#' Visualize by time period.
#'
#' @description Visualize time-based data over time.
#' @details 'multi' version is for facetting.
#' @param data data.frame.
#' @param colname_timebin character. Name of column in \code{data} to use for x-axis.
#' Probably something like 'yyyy', 'mm', etc.
#' @param geom character. 'bar' or 'hist'. 'bar' is probably best for everything except Date objects.
#' @param colname_color character. Name of column in \code{data} to use for color basis.
#' Set to \code{NULL} by default although not actually required in order to simplify internal code.
#' @param color chracter. Hex value of color. Default is provided.
#' @param lab_title character. Default is provided.
#' @param lab_subtitle character. Probably something like 'By Year', 'By Month', etc.
#' Set to \code{NULL} by default although not actually required in order to simplify internal code.
#' @param theme_base \code{ggplot2} theme, such as \code{ggplot2::theme_minimal()}. Default is provided.
#' @return gg
#' @export
#' @importFrom temisc theme_te_a
#' @seealso \url{https://juliasilge.com/blog/ten-thousand-tweets/}.
visualize_time <-
  function(data = NULL,
           colname_timebin = NULL,
           geom = c("bar", "hist"),
           colname_color = NULL,
           color = "grey50",
           lab_title = "Count Over Time",
           lab_subtitle = NULL,
           theme_base = temisc::theme_te_a()) {
    if (is.null(data))
      stop("`data` must not be NULL.", call. = FALSE)
    if (is.null(colname_timebin))
      stop("`colname_timebin` must not be NULL.", call. = FALSE)
    if (is.null(colname_color)) {
      data$color <- "dummy"
      colname_color <- "color"
      data <- coerce_col_to_factor(data, colname_color)
    }
    geom <- match.arg(geom)
    viz_labs <-
      ggplot2::labs(
        x = NULL,
        y = NULL,
        title = lab_title,
        subtitle = lab_subtitle
      )
    viz_theme <-
      theme_base +
      ggplot2::theme(panel.grid.major.x = ggplot2::element_blank()) +
      ggplot2::theme(legend.position = "none")

    viz <- ggplot2::ggplot(data = data, ggplot2::aes_string(x = colname_timebin))
    if (geom == "bar") {
      viz <-
        viz +
        ggplot2::geom_bar(ggplot2::aes_string(y = "..count..", fill = colname_color))
    } else if (geom == "hist") {
      viz <-
        viz +
        ggplot2::geom_histogram(ggplot2::aes_string(y = "..count..", fill = colname_color),
                                bins = 30)
    }

    viz <-
      viz +
      ggplot2::scale_fill_manual(values = color) +
      viz_labs +
      viz_theme
    viz
  }

#' @inheritParams visualize_time
#' @param ... dots. Parameters to pass to \code{visualize_time()}.
#' @param colname_multi character. Name of column in \code{data} to use for facetting.
#' @rdname visualize_time
#' @export
#' @importFrom ggplot2 facet_wrap
#' @importFrom temisc theme_te_a
visualize_time_multi <- function(..., theme_base = temisc::theme_te_a_facet(), colname_multi = NULL) {
  if(is.null(colname_multi)) stop("`colname_multi` cannot be NULL.", call. = FALSE)
  viz <- visualize_time(..., theme_base = theme_base)

  viz <-
    viz +
    ggplot2::facet_wrap(paste0("~ ", colname_multi), scales = "free")
  viz
}

#' Visualize over multiple time periods
#'
#' @description Visualize time-based data over time.
#' @details Calls \code{visualize_time()}.
#' @param data data.frame (single).
#' @param colnames_x character (vector).
#' @param geoms character (vector).
#' @param labs_subtitle character (vector).
#' @param colors character (vector).
#' @param color_chars character (vector).
#' @return gg
visualize_time_batched <-
  function(data = NULL,
           colnames_x = c("timestamp", "yyyy", "mm", "wd", "hh"),
           geoms = c("hist", "bar", "bar", "bar", "bar"),
           labs_subtitle = c("", "By Year", "By Month", "By Day of Week", "By Hour"),
           colors = rep("grey50", 5),
           color_chars) {
    if (is.null(data)) {
      stop("`data` must not be NULL.", call. = FALSE)
    }

    num_colnames_x <- length(colnames_x)
    if (!(num_colnames_x == (
      length(geoms) &
      num_colnames_x == length(labs_subtitle) &
      num_colnames_x == length(colors)
    )))
      stop("List elements must have same length.", call. = FALSE)

    data_rep <- tidyr::nest(data)
    # This is temisc::repeat_df().
    num_rep <- length(colnames_x)
    data_rep <- data[rep(seq_len(nrow(data)), num_rep),]
    viz_bytime_params <-
      list(
        data = data_rep$data,
        colname_timebin = colnames_x,
        geom = geoms,
        color = colors,
        lab_subtitle = labs_subtitle
      )

    if (!missing(color_chars)) {
      if (length(color_chars != num_colnames_x))
        stop("List elements must have same length.", call. = FALSE)
      viz_bytime_params$colname_color <- color_chars
    }

    helper_func <-
      function(data,
               colname_timebin,
               geom,
               lab_subtitle,
               color,
               colname_color = NULL) {
        visualize_time(
          data = data,
          colname_timebin = colname_timebin,
          geom = geom,
          lab_subtitle = lab_subtitle,
          colname_color = colname_color,
          color = color
        )
      }

    viz_bytime_list <- purrr::pmap(viz_bytime_params, helper_func)
    viz_bytime_list
  }