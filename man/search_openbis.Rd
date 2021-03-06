% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/search.R
\name{search_openbis}
\alias{search_openbis}
\alias{search_criteria}
\alias{search_sub_criteria}
\alias{property_clause}
\alias{any_property_clause}
\alias{any_field_clause}
\alias{attribute_clause}
\alias{time_attribute_clause}
\alias{list_property_types}
\title{Assemble and execute openBIS search queries}
\usage{
search_openbis(token, criteria, target_object = c("data_set", "experiment",
  "material", "sample"), fetch_options = NULL, ...)

search_criteria(..., operator = "all", sub_criteria = NULL)

search_sub_criteria(criteria, type = "sample")

property_clause(property_code, value, ...)

any_property_clause(value, ...)

any_field_clause(value, ...)

attribute_clause(attribute = "code", value, ...)

time_attribute_clause(attribute = "registration", value = Sys.Date(),
  timezone = 0L, ...)

list_property_types(token, with_relations = FALSE, ...)
}
\arguments{
\item{token}{Login token as created by \code{login_openbis()}.}

\item{criteria}{A single \code{SearchCriteria} object.}

\item{target_object}{The object type the search is targeted at, i.e.
\code{DataSet}s, \code{Experiment}s, etc.}

\item{fetch_options}{If samples are searched for, additional fetch options
can be specified.}

\item{...}{For \code{search_openbis()} passed to \code{\link[=make_request]{make_request()}}, for
\code{search_criteria()} a set of match clause objects, and for match clause
constructors, the comparison mode can be passed as \code{mode} argument, which
may be \code{eq} (==), \code{lte} (<=) or \code{gte} (>=).}

\item{operator}{How to combine search clauses, either \code{all} or \code{any} have
to be fulfilled.}

\item{sub_criteria}{Optionally, one or several \code{SearchSubCriteria} objects
can be used to create a \code{SearchCriteria} object.}

\item{type}{The entity type, a \code{SearchSubCriteria} is applied to.}

\item{property_code}{Code identifying a property to be used for the
comparison.}

\item{value}{The value used in the comparison.}

\item{attribute}{Name of the attribute to be used for the comparison.}

\item{timezone}{A string identifying the timezone of the specified date,
examples include "+1", "-5", "0", etc.}

\item{with_relations}{Logical switch indicating whether relations should
be returned as well.}
}
\description{
Searching in openBIS presents a powerful alternative to iterative listing
and selecting of objects. As an example, in order to find image data sets
associated with an experiment, instead of first listing all experiments,
selecting the one of interest, then listing all plates of that experiment,
followed by listing image data sets for each of the plates, the requested
data sets can be directly retrieved by constructing a search query with
\code{search_criteria()} and executing the search by calling \code{search_openbis()}.
}
\details{
Searching openBis can be done by creating a \code{SearchCriteria} object and
passing that to \code{search_openbis()}, alongside specifying what type of
object is being searched for. In case of \code{Sample}s being searched for,
a further argument, \code{fetch_options}, can be specified for controlling the
search, which can contain one or more of the strings
\itemize{
\item \code{ancestors}: Ask for all ancestors.
\item \code{basic}: Samples will have only basic attributes (id, code, type, space
code, experiment identifier, registrator, registration date,
modification date) but no properties.
\item \code{children}: Samples contain also their children samples.
\item \code{contained}: Ask for contained samples.
\item \code{descendants}: Ask for all descendants.
\item \code{metaprojects}: Ask for metaprojects this sample belongs to.
\item \code{parents}: Samples contain also their parent samples.
\item \code{properties}: Samples contain basic attributes and all properties.
}

A \code{SearchCriteria} object can be instantiated using the constructor
\code{search_criteria()}, which takes one or several match clause objects, a
search operator specifying whether to match \code{all} or \code{any} clauses, and
optionally one or several \code{SearchSubCriteria} objects. \code{SearchSubCriteria}
objects in turn can be created with \code{search_sub_criteria()}, which takes a
single \code{SearchCriteria} object alongside a string specifying the entities,
the sub criterion is applied to. Possibilities are
\itemize{
\item \code{data_set_container}
\item \code{data_set_parent}
\item \code{data_set_child}
\item \code{experiment}
\item \code{sample}
\item \code{sample_container}
\item \code{sample_child}
\item \code{sample_parent}
}

\code{SearchCriteria} objects, used for searching openBis, consist of one or
several match clauses. A match clause, broadly speaking, consist of a
desired value, a field to which this value is compared to and a comparison
operator (e.g. equality). Match clauses can be constructed using any of
\code{attribute_clause()}, \code{time_attribute_clause()}, \code{property_clause()},
\code{any_property_clause()}, and \code{any_field_clause()}. Attribute match clauses
have a fixed set of attributes against which the match is performed:
\itemize{
\item time attribute match clauses
\itemize{
\item \code{registration_date}
\item \code{modification_date}
}
\item attribute match clauses
\itemize{
\item \code{code}
\item \code{type}
\item \code{perm_id}
\item \code{space}
\item \code{project}
\item \code{project_perm_id}
\item \code{metaproject}
\item \code{registrator_user_id}
\item \code{registrator_first_name}
\item \code{registrator_last_name}
\item \code{registrator_email}
\item \code{modifier_user_id}
\item \code{modifier_first_name}
\item \code{modifier_last_name}
\item \code{modifier_email}
}
}

In order to determine the possible values that can be supplied to
\code{property_clause()} as \code{property_code}s, \code{list_property_types()} can be
called. This function returns all property types available throughout the
queried openBis instance. As objects of several types
(\code{ControlledVocabularyPropertyType} and \code{PropertyType}) are returned as
property types by the API, the resulting object is a list with each entry
corresponding to a type and holding a set of object of the respective type.

The comparison operator (default is equality) can be any of the following
\itemize{
\item \code{equals}
\item \code{less_than_or_equal}, with alias \code{lte}
\item \code{greater_than_or_equal}, with alias \code{gte}
}

All of the option matching is not case-sensitive and is performed with
\code{\link[base:match.arg]{base::match.arg()}} and therefore options may be abbreviated (e.g. \code{eq}
instead of \code{equals}).
}
\section{openBIS}{

\itemize{
\item \Sexpr{infx::docs_link("gis", "searchForDataSets")}
\item \Sexpr{infx::docs_link("gis", "searchForExperiments")}
\item \Sexpr{infx::docs_link("gis", "searchForMaterials")}
\item \Sexpr{infx::docs_link("gis", "searchForSamples")}
}
}

\examples{
\donttest{
  tok <- login_openbis()
  
  # search for an experiment, e.g. ADENO-AU-K1
  exp <- search_openbis(tok,
                        search_criteria(
                          property_clause("pathogen", "Adenovirus"),
                          property_clause("library", "Ambion"),
                          property_clause("geneset", "Kinome"),
                          property_clause("replicate", 1L)
                        ),
                        target_object = "experiment")

  # the same can be achieved using the code attribute
  identical(exp,
            search_openbis(tok,
                           search_criteria(
                             attribute_clause(value = "ADENO-AU-K1")
                           ),
                           target_object = "experiment"))

  # of using the perm_id attribute
  identical(exp,
            search_openbis(tok,
                           search_criteria(
                             attribute_clause("perm_id",
                                              "20111223100933426-318017")
                           ),
                           target_object = "experiment"))

  # a search with no matches returns an empty list
  search_openbis(tok,
                 search_criteria(attribute_clause(value = "foo_bar")),
                 target_object = "experiment")

  # search using sub-criteria: all plate samples of experiment ADENO-DU-K1
  sub <- search_sub_criteria(search_criteria(
                               attribute_clause(value = "ADENO-DU-K1")
                             ),
                             type = "experiment")
  all <- search_openbis(
    tok,
    search_criteria(
      attribute_clause("type", "PLATE"),
      sub_criteria = sub
    ),
    target_object = "sample"
  )
  length(as_json_vec(all))

  # now only include ADENO-DU-K1 plate samples registered after Feb 1st 2013
  some <- search_openbis(
    tok,
    search_criteria(
      attribute_clause("type", "PLATE"),
      time_attribute_clause(value = as.Date("2013-02-01"), mode = "gte"),
      sub_criteria = sub
    ),
    target_object = "sample"
  )
  length(as_json_vec(some))

  logout_openbis(tok)
}

}
